Return-Path: <netdev+bounces-261085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH9lFAxnn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:18:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEE19DC20
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F95430C16C6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65311314D15;
	Wed, 25 Feb 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2TACfJM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D330F922
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054160; cv=none; b=pgrxdEdtA+yXpwH6tDCIo8NwRRKNmVt5nc4BYcRXhuhgWHAZDNhN8C9TglHqWtLfddIi66aRC6bgqW8mgOPwPglr03B/8Gw55l4xGVMe5MUJsWClqwDcGLEzku+1ERSGisxvxDyMYFlyyCFXZAJwwuN6355Aa5orwjU6MsRJsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054160; c=relaxed/simple;
	bh=BceDO1lWMoKFD6z4ktQ3P5Lo8MQAF++Bz9Jxyty0ryY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4yGFATgG7fIL5pI7te9JQitci9MoZ4hda7FP1/Cyj9ce22oJXpplF9wWtSNtb11bSOV6DMPmL99XJdozEh/E4FY/v2EKTZCt6espXulxMXJuAji2LIuLOyCgdw7Nb/dQqbl4r88EKmgvb8Eo53aeaE+HK5heITF4izs6dfYUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2TACfJM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054159; x=1803590159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BceDO1lWMoKFD6z4ktQ3P5Lo8MQAF++Bz9Jxyty0ryY=;
  b=Y2TACfJMrSRi8D/2bhvuUpr9kqQHUsdkiqvZFCvcKXD0zziI3zkSQEK+
   NhMdzIdlYtsSx78Wz45oHO3E89udJOSurAPToMn4rrv9UZHShsy/vIEEz
   3MQ5GvvbsIm09B480yrIEASxxvHR9fYrYUUIrEuEc8ZhS1DcBdWu5Z+2t
   TrezFJ//7NokVU/Hre08UW778a+JZx/2HlL6loZ3eDoRBGVTP5/VozHhh
   B/RBRp3V932FIMoJx0H1hWBqkrlGcOMcr0HVimJsDteVeM0u5EfxFZC09
   I+bTw9a9PppU5mKsUYlPT73R8P56jgYqZbgOT08lvg3jf0e1WPqH6zxLa
   w==;
X-CSE-ConnectionGUID: knma9MVyRTGEH8tBvVAXUA==
X-CSE-MsgGUID: va3kqSCYRgG4eD3ubzkRgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013814"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013814"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:57 -0800
X-CSE-ConnectionGUID: TOkjgf7RSI6oT4o+yZZg2A==
X-CSE-MsgGUID: qRQp1OlLSLugHN5Epy+usg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349705"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Joe Damato <joe@dama.to>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v2 09/12] i40e: Fix preempt count leak in napi poll tracepoint
Date: Wed, 25 Feb 2026 13:15:40 -0800
Message-ID: <20260225211546.1949260-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261085-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: BFFEE19DC20
X-Rspamd-Action: no action

From: Thomas Gleixner <tglx@kernel.org>

Using get_cpu() in the tracepoint assignment causes an obvious preempt
count leak because nothing invokes put_cpu() to undo it:

  softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?

This clearly has seen a lot of testing in the last 3+ years...

Use smp_processor_id() instead.

Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 759f3d1c4c8f..dde0ccd789ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
 		__entry->rx_clean_complete = rx_clean_complete;
 		__entry->tx_clean_complete = tx_clean_complete;
 		__entry->irq_num = q->irq_num;
-		__entry->curr_cpu = get_cpu();
+		__entry->curr_cpu = smp_processor_id();
 		__assign_str(qname);
 		__assign_str(dev_name);
 		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
-- 
2.47.1


