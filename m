Return-Path: <netdev+bounces-304068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sFFTCOAyRmqBLgsAu9opvQ
	(envelope-from <netdev+bounces-304068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C8A6F56AD
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WejxZ+1O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304068-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304068-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68A4A315AA44
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F8D47DF99;
	Thu,  2 Jul 2026 09:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079248A2C2
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984916; cv=none; b=IgZYPtAfclvzRJPmOWR32pxbV4Bw3EcJLf1OVol8/MhXrbGnh/CuxBDeCs0WC1MMG1oi28NfBBfqEIKEPhN4NhjDGb3qSO1VU+f2I3ulMFnQbR4DkAdfilDVU95XGKHBISHm8woGE/Dby10F4djEL4UAx1w/MFP5V3Phv+0WT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984916; c=relaxed/simple;
	bh=P9Br3KZ4AxYc5qdHysl9fMf0MwuoW9MBAdipkCi8Oes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIndrKQ+v3WmRJSInKgidVcX7yiuGgRVfrRkkOW5nm9BLxMj4hM1qn+QbgBxUGzlItwnLaWbK7nOoxavn7dR6fKJbqo4k8jrOhJgNYUYYKcz7GUOm/cc9/lOmwXBHQUGVqj2l8k1jAbhgLzHKpccVsPDIZLVZOZJ25jNX0XrBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WejxZ+1O; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984914; x=1814520914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9Br3KZ4AxYc5qdHysl9fMf0MwuoW9MBAdipkCi8Oes=;
  b=WejxZ+1OBOlHk/EZVvHSpfcTjKBWaiyi9ZAvUMxHQBf0ZuDrE5+GbwOa
   +RHWUXgUK7C1xwwfOoGSBKAPe6FcEs0VxBiPZtqCDZS+HqIWRjOtWIXDM
   0NpQ44LGHGcMA1hgKennFPdr6QpC5zqE/bd2MlAz/HVtbt180UfNWRy0i
   VrLS39iMfz5yItfkCcLLalAR1RgIxlTlRGKfoPxkn03uA66yb6avXejjI
   C0oXG79PN3jdQKm2JmIUFkbGCKXFJ2rpV2LmuWO7ZobDGxCjnfqwloJXs
   Q71SBBCAJCK5eG0CPQ178qUpkI365zFy6OP3hWjIARBa5IZ36WcW50nR5
   g==;
X-CSE-ConnectionGUID: 8nEQuvGATkima84jSQNQTQ==
X-CSE-MsgGUID: vC+kj5GmRNmrBDHhiF8O8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649804"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649804"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:14 -0700
X-CSE-ConnectionGUID: zQWOpmhmSGuj2zZvvjH0uA==
X-CSE-MsgGUID: pE8vijKhRQy4JwKpFSNtwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476409"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:13 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 2/6] ixgbe: E610: prevent from disabling LSE
Date: Thu,  2 Jul 2026 11:15:49 +0200
Message-Id: <20260702091553.57112-3-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304068-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:jedrzej.jagielski@intel.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87C8A6F56AD

LSE is not allowed to be switched off while the ixgbe driver is running.
Some of the ixgbe_aci_get_link_info() callers called it with @ena_lse
equal to false what was causing issues.

There was a known issue when FW after being called by Redfish MGMT request
to disable an interface wasn't able to notify the driver about link status
change due to disabled LSE reception on the driver side. As a result driver
exposed incorrect link status.

There's no any requirement forcing to disable LSE either during configuring
FC, either during setting PHY params.

Force calling ixgbe_aci_get_link_info() with @ena_lse == true.

Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index d451da68fd6d..54cc0f116e88 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1913,7 +1913,7 @@ void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw)
 	/* Get current link err.
 	 * Current FC mode will be stored in the hw context.
 	 */
-	err = ixgbe_aci_get_link_info(hw, false, NULL);
+	err = ixgbe_aci_get_link_info(hw, true, NULL);
 	if (err)
 		goto no_autoneg;
 
@@ -2219,7 +2219,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 	u64 phy_type_low = 0, phy_type_high = 0;
 	int err;
 
-	err = ixgbe_aci_get_link_info(hw, false, NULL);
+	err = ixgbe_aci_get_link_info(hw, true, NULL);
 	if (err)
 		return err;
 
-- 
2.31.1


