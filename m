Return-Path: <netdev+bounces-303403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ktJUHOtORGrFsQoAu9opvQ
	(envelope-from <netdev+bounces-303403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0E6E8A06
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:19:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gCnZUMm3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303403-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303403-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D1B9300F624
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06C226D05;
	Tue, 30 Jun 2026 23:18:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EED323417;
	Tue, 30 Jun 2026 23:18:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861532; cv=none; b=ajpF8Anotp+g7t46fsLBpYaqxirT/ar0E8mJsoz20Z0Shzncuz6USUXoWefO0Vmxxh7SD0SKk6zLpyakK9jxJ35QP67XqxrRRGCgfjBT3isZHlRrdbxEjkcKAqFX8wdGgoapmx2/I6fBZ1oEn7TjzGMaHnAkYDrxFDIQgdIHaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861532; c=relaxed/simple;
	bh=H++89qxpLaHmACQBNFHOWU+EDWqINXpJ1HRaaNeroTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=h3bhnPKMY5ptYqok2IPduWbFyexiu7AwKTbMJtrg+fwZsnyPt+qPo0umSEGmfbNh3tlKXw9KH4fTPyrSBEZzEWx0HobENdLyXockMV9dnT6sk2kNF5tKsCtsH7TrKIXicexnI0OALnXY3XoYD4OiYEouu9dm/Pu9AJb8ZnKDyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCnZUMm3; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782861531; x=1814397531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=H++89qxpLaHmACQBNFHOWU+EDWqINXpJ1HRaaNeroTY=;
  b=gCnZUMm3V0TCiGfomrpOJSKjPY26tsVXZV9ukVqU1w3rduhRso43q2HL
   AiBXxfgK4dxKXavFlMsC8v0bzZIMCu5fUn0z2dZrZfsI3QNfPZaYS8iR5
   X//jYeQ1D6ysPbXtCY4H5mVX40Wo/GpB3VD99Zt0Jf6a/C+OBkTYxfLbE
   gPzV4PVzURha2A37BoC+EewNCfhUSFnVCYQHoVGZGLHhdTtSaIx9c23ZN
   bVLZ5XSI57MRWK62/w6bf/fpgmaUWlLbRvu7d6uWd12kyQ5BoEKbYicLt
   eH8bm4xIdxvXGY9R9Orjwv0ademUXOFhW6mChm6FnXKjycF9r5ySbXgV9
   w==;
X-CSE-ConnectionGUID: NVcB6EHmRreFnfHLM75Yaw==
X-CSE-MsgGUID: tDAcdpr3QGu2bCNAdBi3vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="86135268"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="86135268"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 16:18:47 -0700
X-CSE-ConnectionGUID: yyQUHXcDRtC0JuuZzxCzRA==
X-CSE-MsgGUID: FaFF0FSRQvaiSIvRKwd3zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251972107"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa008.jf.intel.com with ESMTP; 30 Jun 2026 16:18:48 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	jay.bhat@intel.com,
	ivan.d.barrera@intel.com,
	aleksandr.loktionov@intel.com,
	larysa.zaremba@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	linux-pci@vger.kernel.org,
	madhu.chittim@intel.com,
	decot@google.com,
	willemb@google.com,
	sheenamo@google.com,
	lukas@wunner.de
Subject: [PATCH iwl-next v3 1/2] idpf: remove conditional MBX deinit from idpf_vc_core_deinit()
Date: Tue, 30 Jun 2026 16:18:53 -0700
Message-Id: <20260630231854.11536-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260630231854.11536-1-emil.s.tantilov@intel.com>
References: <20260630231854.11536-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303403-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:jay.bhat@intel.com,m:ivan.d.barrera@intel.com,m:aleksandr.loktionov@intel.com,m:larysa.zaremba@intel.com,m:anthony.l.nguyen@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:linux-pci@vger.kernel.org,m:madhu.chittim@intel.com,m:decot@google.com,m:willemb@google.com,m:sheenamo@google.com,m:lukas@wunner.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FE0E6E8A06

Previously it was assumed that idpf_vc_core_deinit() is always being
called during reset handling, where the MBX is disabled by the reset,
with remove being the exception. Ideally the driver needs to communicate
the changes to FW in all instances where the MBX is not already disabled.
Remove the remove_in_prog check from idpf_vc_core_deinit() as the MBX was
already disabled while handling the reset via libie_ctlq_xn_shutdown()
in the service task. This is also needed by the following patch,
introducing PCI callbacks support, specifically in the case where FLR is
being triggered by a user, in which case, the driver still has the ability
to notify FW before the reset happens.

Add call to libie_ctlq_xn_shutdown() in idpf_shutdown() to avoid a possible
regression where long timeouts can happen on shutdown when FW is down.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Jay Bhat <jay.bhat@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 10 +---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 5a191644b28e..064bf3583824 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -191,6 +191,8 @@ static void idpf_shutdown(struct pci_dev *pdev)
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+	if (adapter->xnm)
+		libie_ctlq_xn_shutdown(adapter->xnm);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e0e510b1f1e1..cc5aeec3d00b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3195,24 +3195,16 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
-	bool remove_in_prog;
-
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	/* Avoid transaction timeouts when called during reset */
-	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
-		libie_ctlq_xn_shutdown(adapter->xnm);
-
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
 	idpf_idc_deinit_core_aux_device(adapter);
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
 
-	if (remove_in_prog)
-		libie_ctlq_xn_shutdown(adapter->xnm);
+	libie_ctlq_xn_shutdown(adapter->xnm);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.37.3


