Return-Path: <netdev+bounces-279963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFXBLWPK5ml40wEAu9opvQ
	(envelope-from <netdev+bounces-279963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8CC4352D3
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E834C301CC7A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5AB221F2F;
	Tue, 21 Apr 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCX+0XZS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192671E5B9A
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732731; cv=none; b=jRtJtKXbdr7nm3d6fuRQxBUosL36EAPrKeotyYvDZ5xE9sFEwG79Ej5KYDQp2WXokBxI6r+rNIi3Sw0DIxvDE2Jz96Hd9uNuY3kKGAO3WqCkbNM0oi/mRNmsFBGt7TQJBL3jgH5pBs65vUjCifYb4oS6pihYsd2ibIhfyCb6c9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732731; c=relaxed/simple;
	bh=S70YaheCQsLDidrsgc+BZ7xDqIgZGs2JKOguHjM3kRs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FeKTZC8nOqMUYrkWXstxFIYIPnqFrmbhoLwLuPU91L/WeIu31MIwPENYKmSPxaQ/GC38KjGVNj58nXQb6RWjPgfpprj9F6KVr2DSMecjvpByxE72zru6G6kLFGvEUflhQnjtGJj8nkrKVc77mHEgqyyVX8h5exM0Y1CkYZsAjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCX+0XZS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776732730; x=1808268730;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=S70YaheCQsLDidrsgc+BZ7xDqIgZGs2JKOguHjM3kRs=;
  b=RCX+0XZSQp4DHa+zae7R2LUO7Ff8kYORCtfyUlNIUkJMcOKY+H8I5I3x
   pqk5xXG6xelZGW6PD3kLo9Pw6MkFkbHIY6/4lSZg1CQdKD96B7k5n9s5F
   qSJjd8ggLbBRp4FaIHYaOLkMjCfrEph+UkJ9DOoMFyil5awt7A6wZo5Z/
   FRGtqCz0Z4GX/zSdfHZW5Lg9qIdhOrLX/I++WhCjbSsTv51Yd0k5qjj6P
   X9EVJ7Qen/ood85JwgncmliXy0gtejxuMeWnaIo2MRblieAIrmd2GFBtR
   gjP4we3iqkTiwEeu8oWjp+1m9X2mxP3ci5SraQ2KhsYQ2vh9TnaF99LZ5
   w==;
X-CSE-ConnectionGUID: VvU/xordR+Ck+JcaaoOTRA==
X-CSE-MsgGUID: d9unD0KbRkCYz6vxdHjKhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77530390"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77530390"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
X-CSE-ConnectionGUID: UXi7ppsXQC6x/12RHFzm/Q==
X-CSE-MsgGUID: fuWcsmtSScaka7UkOfx0kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235886660"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/4] Intel Wired LAN Driver Updates 2026-04-20 (ice)
Date: Mon, 20 Apr 2026 17:51:24 -0700
Message-Id: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2w6CMBBEf4Xss5PUBkH8FeMDlEUWTW3a4iWEf
 3fRp8mZSc4slDgKJzoVC0V+SpKHV9jvCnJj668M6ZXJGluZ0hpMN8jrDs8ZWwdTaiLkAD7ag0M
 YPxCfOcY5ZAzy5oSmbl3lusYMfU1qDpF/g4rPpCa6/Ms0dxO7vP3Run4B5gtirpwAAAA=
X-Change-ID: 20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-97ac6cb90fd7
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Petr Oros <poros@redhat.com>, Sunitha Mekala <sunithax.d.mekala@intel.com>, 
 Timothy Miskell <timothy.miskell@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5807;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=S70YaheCQsLDidrsgc+BZ7xDqIgZGs2JKOguHjM3kRs=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGnmyi+jCVQyT5ZWi3dU5AHAlmA+b7kq/XMN1AgqQFBBDEqRK
 oh1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmnmyi8ACgkQapZdPm8PKOho1AD/U2MS
 SDBMt7XfxbSPNbTJLKV6sxdyNFOIzIOPU0GaSN8A/3q1mNRjKKh0hFFClqQBfaE66oTZEowu6ug
 y4K8TESME
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279963-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 6E8CC4352D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since this is a set of related fixes for just the ice driver, Jake provides
the following description for the series:

We recently ran into a nasty corner case issue with a customer operating
E825C cards seeing some strange behavior with missing Tx timestamps. During
the course of debugging. This series contains a few fixes found during this
debugging process.

The primary issue discovered in the investigation is a misconfiguration of
the E825C PHY timestamp interrupt register, PHY_REG_TS_INT_CONFIG. This
register is responsible for programming the Tx timestamp behavior of a PHY
port. The driver programs two values here: a threshold for when to
interrupt and whether the interrupt is enabled.

The threshold value is used by hardware to determine when to trigger a Tx
timestamp interrupt. The interrupt cause for the port is raised when the
number of outstanding timestamps in the PHY port timestamp memory meets the
threshold. The interrupt cause is not cleared until the number of
outstanding timestamps drops *below* the threshold.

It is considered a misconfiguration if the threshold is programmed to 0. If
the interrupt is enabled while the threshold is zero, hardware will raise
the interrupt cause at the next time it checks. Once raised, the interrupt
cause for the port will never lower, since you cannot have fewer than zero
outstanding timestamps.

Worse, the timestamp status for the port will remain high even if the
PHY_REG_TS_INT_CONFIG is reprogrammed with a new threshold. The PHY is a
separate hardware block from the MAC, and thus the interrupt status for the
port will remain high even if you reset the device MAC with a PF reset,
CORE reset, or GLOBAL reset.

PHY ports are connected together into quads. Each quad muxes the PHY
interrupt status for the 4 ports on the quad together before connecting
that to the MACs miscellaneous interrupt vector. As a result, if a single
PHY port in the quad is stuck, no timestamp interrupts will be generated
for any timestamp on any port on that quad.

The ice driver never directly writes a value of 0 for the threshold.
Indeed, the desired behavior is to set the threshold to 1, so that
interrupts are generated as soon as a single timestamp is captured.
Unfortunately, it turns out that for the E825C PHY, programming the
threshold and enable bit in the same write may cause a race in the PHY
timestamp block. The PHY may "see" the interrupt as enabled first before it
sees the threshold value. If the previous threshold value is zero (such as
when the register is initialized to zero at a cold power on), the hardware
may race with programming the threshold and set the PHY interrupt status to
high as described above.

The first patch in this series corrects that programming order, ensuring
that the threshold is always written first in a separate transaction from
enabling the interrupt bit. Additionally, an explicit check against writing
a 0 is added to make it clear to future readers that writing 0 to the
threshold while enabling the interrupt is not safe.

The PHY timestamp block does not reset with the MAC, and seems to only
reset during cold power on. This makes recovery from the faulty
configuration difficult. To address this, perform an explicit reset of the
PHY PTP block during initialization. This is achieved by writing the
PHY_REG_GLOBAL register. This performs a PHY soft reset, which completely
resets the timestamp block. This includes clearing the timestamp memory,
the PHY timestamp interrupt status, and the PHY PTP counter. A soft reset
of all ports on the device is done as part of ice_ptp_init_phc() during
early initialization of the PTP functionality by the PTP clock owner, prior
to programming each PHY. The ice_ptp_init_phc() function is called at
driver init and during reinitialization after all forms of device reset.
This ensures that the driver begins operation at a clean slate, rather than
carrying over the stale and potentially buggy configuration of a previous
driver.

While attempting to root cause the issue with the PHY timestamp interrupt,
we also discovered that the driver incorrectly assumes that it is operating
on E822 hardware when reading the PHY timestamp memory status registers in
a few places. This includes the check at the end of the interrupt handler,
as well as the check done inside the PTP auxiliary function. This prevented
the driver from detecting waiting timestamps on ports other than the first
two.

Finally, the ice_ptp_read_tx_hwstamp_status_eth56g() function was
discovered to only read the timestamp interrupt status value from the first
quad due to mistaking the port index for a PHY quad index. This resulted in
reporting the timestamp status for the second quad as identical to the
first quad instead of properly reporting its value. This is a minor fix
since the function currently is only used for diagnostic purposes and does
not impact driver decision logic.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Grzegorz Nitka (2):
      ice: fix timestamp interrupt configuration for E825C
      ice: perform PHY soft reset for E825C ports at initialization

Jacob Keller (2):
      ice: fix ready bitmap check for non-E822 devices
      ice: fix ice_ptp_read_tx_hwtstamp_status_eth56g

 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   5 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  44 ++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 253 +++++++++++++++++++++++++++-
 3 files changed, 269 insertions(+), 33 deletions(-)
---
base-commit: a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
change-id: 20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-97ac6cb90fd7

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


