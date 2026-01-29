Return-Path: <netdev+bounces-254919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMfSC7DWe2klIwIAu9opvQ
	(envelope-from <netdev+bounces-254919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:52:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84838B51AE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E012300E3AC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0A3385A5;
	Thu, 29 Jan 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKLVvsVX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E32366831
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723565; cv=none; b=MJ/74EFClCvukB6Sn1mdnZOpeO3w0gwi098734yWhctQ6WQ24XNf3nY0Hs5YR3HuhaJ+aUn2qQIhRCIpcKVhiOScjp2BjsUSurOh+Imc9Eo0fHOBUcrQjOLs66V0NH4+LKrTHtNMCThe09C/7wGmIBA3ygZu6ZISgbU73RqlHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723565; c=relaxed/simple;
	bh=mdOjVbsypDRwFTpeTgSO5uLjV0okQUVzWRSA7tx9Iac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ECYhMXVpWldrsRc96FFS8vfFhXJFvypcgHvG7wQdiHkCy5erN+Hd0LM55GjYI+PsK3X4S6tPR+Zs/+d1J52mYWGkawaY1KdlmCOm5qHbgSPExzFOjKF74uktDATPPEhyD01s/ma9a/kiawSU9TZLZ0jXVoM79NngVSiT3l+7/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKLVvsVX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769723564; x=1801259564;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=mdOjVbsypDRwFTpeTgSO5uLjV0okQUVzWRSA7tx9Iac=;
  b=iKLVvsVXcTldjycO2S1XEO27tF5l4cfVLm0L63BSbwAbIh1cjPRzHC7a
   pRW1v+rGEqADUepOgbOxS+aFhkbIeg5UnkAbrzGva90RVnvnCkk2kqEFH
   sysAHvwv3E59OhYpWhqOxnUFUlCf9RxHNsRKDqp1sBuo7rmAVVk9eFXtA
   PgCA37rylxE0nJcsbCfd183VjKREV7ESx4J3uDmEnuFBgXyrmWQazF58U
   brUUQo6nFdxDUJ0bBAUUkXjrqc3ZQCP5zhHiGTEY1uU9RYcWFw6l8a3c/
   mnD/zTIM5N3ZDdO+nTE1y18g8OHWVJikltPIO1+EuXCgnX9iv9Z05yhlN
   w==;
X-CSE-ConnectionGUID: F7J73fo8S1STcFgK0SP5vA==
X-CSE-MsgGUID: ZiabcPFBSZKAPmOx83bm4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71013287"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="71013287"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 13:52:42 -0800
X-CSE-ConnectionGUID: c8hxNuRAS3KoYRTIn17JDw==
X-CSE-MsgGUID: 64tK2ZBmTwKesOV8cxxVYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208797888"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 13:52:42 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 29 Jan 2026 13:52:05 -0800
Subject: [PATCH iwl-next] i40e: only timestamp PTP event packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBAAv2L27BqWVkBP/sNwQNzCKi2kbRBD+
 LsNL/A4mWRmhcBeOMD1sILnWYKMLgEdD9D2jesY5ZkY8iw/E5HC1xtFZ4yDWIkYxXKIjZ3EdVj
 pUpvWKMU6gxSYPBtZ9vgd5DOg4yVCnUwvIY7+u19n2v0/g5mQsNCcXypTcvFQN3GRh1M7Wqi3b
 fsBPCfo6c4AAAA=
X-Change-ID: 20251113-jk-i40e-limit-timestamping-8474fcf33e40
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org
Cc: przemyslaw.korba@intel.com, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=5306;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=mdOjVbsypDRwFTpeTgSO5uLjV0okQUVzWRSA7tx9Iac=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszqa8tE96gx71XNu1PhvPFZpfN03da7tfV8wbN+zC3Pe
 +TI+E6lo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgImE6DIy3FfuvdQy86tjbtEP
 qVkNN1iVd+j8mOY3w11C0XjrU2POYwz/1CbcWBx532OTbHsZw6NgtqdKorfuX5Iw3RSvKids9ia
 RCQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254919-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 84838B51AE
X-Rspamd-Action: no action

The i40e_ptp_set_timestamp_mode() function is responsible for configuring
hardware timestamping. When programming receive timestamping, the logic
must determine how to configure the PRTTSYN_CTL1 register for receive
timestamping.

The i40e hardware does not support timestamping all frames. Instead,
timestamps are captured into one of the four PRTTSYN_RXTIME registers.

Currently, the driver configures hardware to timestamp all V2 packets on
ports 319 and 320, including all message types. This timestamps
significantly more packets than is actually requested by the
HWTSTAMP_FILTER_PTP_V2_EVENT filter type.

The documentation for HWTSTAMP_FILTER_PTP_V2_EVENT indicates that it should
timestamp PTP v2 messages on any layer, including any kind of event
packets.

Timestamping other packets is acceptable, but not required by the filter.
Doing so wastes valuable slots in the Rx timestamp registers. For most
applications this doesn't cause a problem. However, for extremely high
rates of messages, it becomes possible that one of the critical event
packets is not timestamped.

The PTP protocol only requires timestamps for event messages on port 319,
but hardware is timestamping on both 319 and 320, and timestamping message
types which do not need a timestamp value.

The i40e hardware actually has a more strict filtering option. First, only
timestamp layer 4 messages on port 319 instead of both 319 and 320. Second,
note that hardware has a specific mode to timestamp only event packets
(those with message type < 8).

Update the configuration to use this mode, so that timestamps are captured
for only event messages. This replaces the use of the 'wildcard' option of
the V2MESSTYPE field which caused timestamping of all message types
regardless of whether it was an event message.

This avoids wasting the valuable Rx timestamp register slots on non-event
frames, and may reduce faults when operating under high event rates.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  9 +++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index c4051dbcc297..2560c47910d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -797,8 +797,18 @@
 #define I40E_PRTTSYN_CTL1_V2MESSTYPE0_SHIFT 16
 #define I40E_PRTTSYN_CTL1_V2MESSTYPE0_MASK I40E_MASK(0xF, I40E_PRTTSYN_CTL1_V2MESSTYPE0_SHIFT)
 #define I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT 24
+#define I40E_PRTTSYN_CTL1_TSYNTYPE_MASK I40E_MASK(0x3, I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
+/* Timestamp UDP v1 packets */
+#define I40E_PRTTSYN_CTL1_TSYNTYPE_V1 \
+	FIELD_PREP(I40E_PRTTSYN_CTL1_TSYNTYPE_MASK, 1)
+/* Timestamp L2 and UDP v2 packets with message type < 8 */
+#define I40E_PRTTSYN_CTL1_TSYNTYPE_V2_EVENT \
+	FIELD_PREP(I40E_PRTTSYN_CTL1_TSYNTYPE_MASK, 3)
 #define I40E_PRTTSYN_CTL1_UDP_ENA_SHIFT 26
 #define I40E_PRTTSYN_CTL1_UDP_ENA_MASK I40E_MASK(0x3, I40E_PRTTSYN_CTL1_UDP_ENA_SHIFT)
+/* Timestamp UDP packets on port 319 */
+#define I40E_PRTTSYN_CTL1_UDP_ENA_319 \
+	FIELD_PREP(I40E_PRTTSYN_CTL1_UDP_ENA_MASK, 1)
 #define I40E_PRTTSYN_CTL1_TSYNENA_SHIFT 31
 #define I40E_PRTTSYN_CTL1_TSYNENA_MASK I40E_MASK(0x1, I40E_PRTTSYN_CTL1_TSYNENA_SHIFT)
 #define I40E_PRTTSYN_INC_H 0x001E4060 /* Reset: GLOBR */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 89abe2f22216..d70adf2e5a1c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -24,9 +24,6 @@
 #define I40E_PTP_1GB_INCVAL_MULT	20
 #define I40E_ISGN			0x80000000
 
-#define I40E_PRTTSYN_CTL1_TSYNTYPE_V1  BIT(I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
-#define I40E_PRTTSYN_CTL1_TSYNTYPE_V2  (2 << \
-					I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
 #define I40E_SUBDEV_ID_25G_PTP_PIN	0xB
 
 enum i40e_ptp_pin {
@@ -1278,7 +1275,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 		pf->ptp_rx = true;
 		tsyntype = I40E_PRTTSYN_CTL1_V1MESSTYPE0_MASK |
 			   I40E_PRTTSYN_CTL1_TSYNTYPE_V1 |
-			   I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
+			   I40E_PRTTSYN_CTL1_UDP_ENA_319;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
@@ -1295,9 +1292,9 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
 		pf->ptp_rx = true;
 		tsyntype = I40E_PRTTSYN_CTL1_V2MESSTYPE0_MASK |
-			   I40E_PRTTSYN_CTL1_TSYNTYPE_V2;
+			   I40E_PRTTSYN_CTL1_TSYNTYPE_V2_EVENT;
 		if (test_bit(I40E_HW_CAP_PTP_L4, pf->hw.caps)) {
-			tsyntype |= I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
+			tsyntype |= I40E_PRTTSYN_CTL1_UDP_ENA_319;
 			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		} else {
 			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;

---
base-commit: 38e28dad667f597c26856f2e0c3e95f70e0ab509
change-id: 20251113-jk-i40e-limit-timestamping-8474fcf33e40

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


