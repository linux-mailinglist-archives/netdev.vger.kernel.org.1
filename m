Return-Path: <netdev+bounces-297296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqM4DgyIKGpVFwMAu9opvQ
	(envelope-from <netdev+bounces-297296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:39:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 846976644C6
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:39:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Vg0GIRh4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297296-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A125A3091558
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA353FBED2;
	Tue,  9 Jun 2026 21:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DE3644C3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040971; cv=none; b=r+E7vzTBoeJICC0xekUFHD0hkU757/E5GHIKwUz88DnHB/K3xKUblIutSTEjy47I5PhxWR3meUhsqmK0BZ96hH2ilyxP48HBJRIzEaw0BCLk1sjtD79vZ4j1207evuNOR7jBmawfB+jaTfMuDGuS+YUV6GK4POonV9YEMneHZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040971; c=relaxed/simple;
	bh=pcSEizI3Ez21/tItl5AycJUUJjrkFWUYFda5BeMZkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoQFOLoDtEJJT4nwDun89tmzpQ1MqI4oQEKzwXaiM4ZG5Ea/1PSx/8YsoLtJCaefveZet9Rze1bM+9tlwVu0/IBB8/hQl8SbgsvizRT18cWzTfWjHxChGE9N1IrTReQ1i1AsWd2c+gGtvvsBWpIpmTusLGvS99VHijwmc6rorP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vg0GIRh4; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040970; x=1812576970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pcSEizI3Ez21/tItl5AycJUUJjrkFWUYFda5BeMZkzc=;
  b=Vg0GIRh44HgWiASX3Cg1v8hOFH46YC/uDJM4nNRXgB9DqLb8wXy0w1EO
   +0tuhNxUkJrc025xqE1CQGJE5CVTOJbYi8MYcQUAptoTiREQccNjH7+av
   tSBQZRfCXCAnaPyfeOGjGhLZ61oPkyV8eOeuGCIS16M2VYskIj8Zz/oAN
   cFULqd66IYNnj2Lc+NX2Bol/WrXqbpEwSqf5ThH7E3d2teio20maIhC/l
   uqYDp9aiwXim1YMHRJNXOEFpvBAQEi6ifgUJ2fLf9Fx2Qph3PQIgQmY1K
   EZSoZwkPLgJ67n8Ynhey5AhSBE5tnREm1pgXkRhcBbWNvTSpSlKYdF0qo
   g==;
X-CSE-ConnectionGUID: bzbqcGAGRQOyMEk90fQQDQ==
X-CSE-MsgGUID: 1spsbvPxTcW+6xmIKJWETg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568515"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568515"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:08 -0700
X-CSE-ConnectionGUID: /d4vB7OLRUWeJG3vMmxAGA==
X-CSE-MsgGUID: NwL84OcHRkqvBIUJ2ie+8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838568"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	mhocko@suse.com,
	jiangshanlai@gmail.com,
	frederic@kernel.org,
	tj@kernel.org,
	bigeasy@linutronix.de,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 01/15] idpf: Replace use of system_unbound_wq with system_dfl_wq
Date: Tue,  9 Jun 2026 14:35:42 -0700
Message-ID: <20260609213559.178657-2-anthony.l.nguyen@intel.com>
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
	TAGGED_FROM(0.00)[bounces-297296-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:marco.crivellari@suse.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:mhocko@suse.com,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:tj@kernel.org,m:bigeasy@linutronix.de,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.com,intel.com,gmail.com,kernel.org,linutronix.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 846976644C6

From: Marco Crivellari <marco.crivellari@suse.com>

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f6b3b15364ff..7f9056404f64 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2022,7 +2022,7 @@ static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
 		/* Fetch timestamp from completion descriptor through
 		 * virtchnl msg to report to stack.
 		 */
-		queue_work(system_unbound_wq, txq->tstamp_task);
+		queue_work(system_dfl_wq, txq->tstamp_task);
 		break;
 	}
 
-- 
2.47.1


