Return-Path: <netdev+bounces-283118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEHSJLtK9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218454AAAFC
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F6D13030D4A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F2D3612EE;
	Fri,  1 May 2026 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShQJmyK8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48CE364053;
	Fri,  1 May 2026 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617520; cv=none; b=n5V/Z2xqj1Bpa2wrZTOGcWv7NtKRtNL7nxL7N+a+cxzUfpXyQAVoBcBjCU5RWygJHaLUrfauFeKpjtwKJz8RH017rXY4FmsRTDkiXKh9O8Pq9FU2o1rF2NBQwybEYp+nDTx0aaQ3fHYivbUsRGBA+ocGPBqsIafSrtMKTrKPBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617520; c=relaxed/simple;
	bh=RjzD3QV0Pc7FQKiPpdSySz683TeMOk4ms6dduW8uUiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fR7Gz/b79wixEYJE/SUYxmtqcd7EZgTBlyGDgtgBSKUKYv7VpPK5Q1ZhjW+v8fdHa+iziIFYWaj1Wfp7kdDoucthDAjsl01nwAtpEmUaVwIng/UkD21nXAAxEriC5VD3xQVXS8itMvjnTwBjcKKMLrrqq757/K5Uf+OBGiJS494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShQJmyK8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617519; x=1809153519;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RjzD3QV0Pc7FQKiPpdSySz683TeMOk4ms6dduW8uUiY=;
  b=ShQJmyK8rRzNs7AS2cOwpTdW/eQRRPs3uyMMMcgMZdE9Etx/O8/cVwGW
   3w/mwrds51rwAlRhVa6iFbLxoW6K9+ZJBN/o99GEoKdw1JsKNJLE+rPqw
   85+EK+3js/iabMcyPKB3F4YcG4ThbbDee19DakcOmTstRekhe8XzTCyYf
   R6EClUTlkOKlTZqXQtrNMY2pstRpTk2CK2Eleoz/uRrKNPY1EIHWl/A6X
   hiaJFeY1ljCxCcrdprvuAF/OGXzpZe6RKsaPFaVq36ULFxotPWkiQMxGY
   YnrtGOWbwqAHpQzrXTwp+mplE9uDqBvTljwkP93XCgC7ql4gLZj+L2l89
   g==;
X-CSE-ConnectionGUID: tzFr27DyTOqv/wIBWjRpIg==
X-CSE-MsgGUID: 8RVSWu8WTqyjHEXb+O82vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271922"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:33 -0700
X-CSE-ConnectionGUID: GTP21E5iTyKt05mDHzg8GQ==
X-CSE-MsgGUID: KPmMslOFRGWuw9K8zypH2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752868"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:21 -0700
Subject: [PATCH net-next 10/15] i40e: only timestamp PTP event packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-10-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
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
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5472;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=RjzD3QV0Pc7FQKiPpdSySz683TeMOk4ms6dduW8uUiY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXqkPftw3+PbzwMvtH2QSbr0KbtnVX7yg6KKDZtK/M
 oNM8+fqHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkxXNGhlOT+zINkpd89f52
 60Cg3RJ12b9RuzapLG1+MOHw+ZpnWRyMDHtcL/LfND3nvbwxN9Jt24+rstsW7lsrHbhoj5H2z1X
 ugewA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 218454AAAFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

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

Update the configuration to use the strict mode that only timestamps event
messages, switching the TSYNTYPE field from 10b to 11b which limits the
timestamping only to eventpackets with a Message Type of < 8. Note that the
X700 series datasheet seems to indicate that the V2MSESTYPE field is no
longer relevant. However, we only tested and validated with leaving the
V2MESSTYPE field set to 0xF for the "wildcard" behavior it documents. This
might not be required but it in that case setting it appears harmless, so
leave it as is.

This avoids wasting the valuable Rx timestamp register slots on non-event
frames, and may reduce faults when operating under high event rates.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  9 +++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 432afbb64201..d426d83e0214 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -788,8 +788,18 @@
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
index 404a716db8da..7bcea7d9720f 100644
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
@@ -1219,7 +1216,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 		pf->ptp_rx = true;
 		tsyntype = I40E_PRTTSYN_CTL1_V1MESSTYPE0_MASK |
 			   I40E_PRTTSYN_CTL1_TSYNTYPE_V1 |
-			   I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
+			   I40E_PRTTSYN_CTL1_UDP_ENA_319;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
@@ -1236,9 +1233,9 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
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

-- 
2.54.0.rc2.531.gaf818d63126a


