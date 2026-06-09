Return-Path: <netdev+bounces-297307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SfkoDESJKGp9FwMAu9opvQ
	(envelope-from <netdev+bounces-297307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:44:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F159664507
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Bc1B7BtQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297307-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C8D310BE43
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479AF492508;
	Tue,  9 Jun 2026 21:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351A481652
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040982; cv=none; b=cOqgUoVxjINih3Mb055coITk46OaLbpLN1T+uj2kextsRPLgMYIQTfLLXnEtUYJ+9UkITIVHHJBJYKYS2cWpLc1V8ODPynqhU6r5pHZvPkNiTkPczHquEhAmLmhEZwyLWTbaGJK1akRPX9odBdLAE+F9S7WYw+LRVTcxpb+cepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040982; c=relaxed/simple;
	bh=Cc6mUHVXOuUDPOd/xKmpVugdE+2jCdAaDEYhGUMiQrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COnvNP2p6n1mWNOMFSeFMPM7csYmCZ+ZS1yqSdo00jtI8ic5QUxmVYkr4rCwlNYEzitBHID5r9S3pU5qYHT5NPsRKRn0idj58nrUsMGDG15nVeqiJQs4ZM8oFqfyw4qJmJXiAO8fmF3UfZ2kLn/1/62V3W8rg1+5vMzX1JMCQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc1B7BtQ; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040979; x=1812576979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cc6mUHVXOuUDPOd/xKmpVugdE+2jCdAaDEYhGUMiQrM=;
  b=Bc1B7BtQ9tEr9p79wT+JEOeYdEJp5n5uk+PLtRM3229Uzl4ivKGf6DQ3
   cebpaskOo+P6FMrE2iwrQIFTLnHz2M+s319XfgSCONznv5bLBO9Kss4bT
   LG7uaFu4RTTl6Ll2obOQWqPOfrkUP8glC2z+9nOiWbeh4kbXXAXywyEtb
   szgzfxq8l44QBb0ESC1UAsCQrG9iBzQMoYiUKtMexjqYZmO4lvY1ftQ4c
   9rfVI8K8ZzmLXDKHJ/RjsK30o4Uf59Y7rnsIjIl1dyjSfDsc/ovvrDwDb
   Cy//NPFJeIUUWaQ0+3PzF+aXdmRUYP6uQO9Qk2zbHy6UQoGuQnmj8OtQW
   Q==;
X-CSE-ConnectionGUID: 7tnGDskUQy+B9R3I/WHm3Q==
X-CSE-MsgGUID: +q4NaXWMQteKDMoGLDRJVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568592"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568592"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:09 -0700
X-CSE-ConnectionGUID: 5btvEA3KQXuh0nCpGQO23A==
X-CSE-MsgGUID: PsYzEe2dQJC2a0oLzM8TUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838601"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Matt Vollrath <tactii@gmail.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Cohen <michalx.cohen@intel.com>
Subject: [PATCH net-next 11/15] e1000e: Use __napi_schedule_irqoff()
Date: Tue,  9 Jun 2026 14:35:52 -0700
Message-ID: <20260609213559.178657-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:tactii@gmail.com,m:anthony.l.nguyen@intel.com,m:dima.ruinskiy@intel.com,m:aleksandr.loktionov@intel.com,m:michalx.cohen@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297307-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F159664507

From: Matt Vollrath <tactii@gmail.com>

The __napi_schedule_irqoff() macro is intended to bypass saving and
restoring IRQ state when scheduling is requested from an IRQ handler,
where hard interrupts are already disabled. Use this macro in all three
interrupt handlers.

This was tested on a system with an I218-V and MSI interrupts. Because
this is an optimization, I was interested in measuring the impact, so I
added ktime_get() time measurement to e1000_intr_msi and a print of the
last sample in the watchdog task. For each test case I ran a
bi-directional iperf3 to saturate the line. With some help from awk,
here are the statistics.

49 samples each, all units ns
previous: min 678 max 1265 mean 879.429 median 806 stddev 137.188
noirq:    min 707 max 1165 mean 811.857 median 790 stddev  89.486

According to this informal comparison, the mean time to handle an
interrupt from start to finish is improved by about 8% under load.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Michal Cohen <michalx.cohen@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3bdeb5f0dbea..808e5cddd6a9 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1803,7 +1803,7 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
 		adapter->total_tx_packets = 0;
 		adapter->total_rx_bytes = 0;
 		adapter->total_rx_packets = 0;
-		__napi_schedule(&adapter->napi);
+		__napi_schedule_irqoff(&adapter->napi);
 	}
 
 	return IRQ_HANDLED;
@@ -1882,7 +1882,7 @@ static irqreturn_t e1000_intr(int __always_unused irq, void *data)
 		adapter->total_tx_packets = 0;
 		adapter->total_rx_bytes = 0;
 		adapter->total_rx_packets = 0;
-		__napi_schedule(&adapter->napi);
+		__napi_schedule_irqoff(&adapter->napi);
 	}
 
 	return IRQ_HANDLED;
@@ -1951,7 +1951,7 @@ static irqreturn_t e1000_intr_msix_rx(int __always_unused irq, void *data)
 	if (napi_schedule_prep(&adapter->napi)) {
 		adapter->total_rx_bytes = 0;
 		adapter->total_rx_packets = 0;
-		__napi_schedule(&adapter->napi);
+		__napi_schedule_irqoff(&adapter->napi);
 	}
 	return IRQ_HANDLED;
 }
-- 
2.47.1


