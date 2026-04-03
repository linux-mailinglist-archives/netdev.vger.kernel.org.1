Return-Path: <netdev+bounces-275191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DkBA7Ma0Gl33QYAu9opvQ
	(envelope-from <netdev+bounces-275191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:53:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82575397EE4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB02B301D329
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66793D47CD;
	Fri,  3 Apr 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO6MuT2D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9C3D6CB3;
	Fri,  3 Apr 2026 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245800; cv=none; b=miZByHfSI+vcGzBbJvBBO0eKfDHOZb/WFUmOmo4CgxQ1wsfLLnKeLNs8ihsF/toThBKvHTOuB2j8dSn9VmbgsxLC2J/eCgVVbzzg6bBtlesyd55pRTVOVaMZPUsv0vczHIPm27mE6qKGr8LKZJB9kbEZu+RGfQi+2dINSz45j8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245800; c=relaxed/simple;
	bh=WNgrh53dXK0aDHnzZhDAO6vOCVJFKDOlTm5Llb0hNwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ziam0KSouEqqT+czT9A4jTSU/7L/3n8yZHZwQFQ0KfBwj0MYV052agAw7pJwLKbCS5/WYD0WUpU/9HppXG5GPDzs/qXHrf7cW+GPm45BOmwoYU0k+qFVjL+PpclwVW4dCueuh0yHXsOA+1CNkVr8iA18eOZ1SAdUuNIGJs8Tr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO6MuT2D; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775245796; x=1806781796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WNgrh53dXK0aDHnzZhDAO6vOCVJFKDOlTm5Llb0hNwk=;
  b=TO6MuT2DH59bM1giuJT9pvq5AZx+EvxQ0flDIx1dvWfD23KKkVvry/LJ
   bjGXRIsm0kMqhVenumrklq0V2OPoB7s6wfE4HBh6jcGo64+LM/MirFwMY
   SDLCo20ZvqIPjCGbQ0R7ad9AewPnSrcdetJIXyC31WbKRvbYgrHB49j2O
   XQAGWI8qANhupNVCQp1mNnQP8OUfUrkoGzUC5BuTAcZjnnVeT+bT9dWfS
   sARphO4YZIU3rr997iHcqDwT8M4OVOSJf/T9rkURdH0o46KBw5VACoEJG
   taMiQGz9Sujhy/b6CJMZprTu4MDsQl79mtyRLwQJmQq1uXNE9pMZI+4I5
   A==;
X-CSE-ConnectionGUID: 5sZfXfBQRnifb/QgZ6XYuQ==
X-CSE-MsgGUID: rB/dn2MDRZy0KPjg2loZbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76428827"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76428827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:49:47 -0700
X-CSE-ConnectionGUID: RWUmGipnQM20c+XNxc7Ndg==
X-CSE-MsgGUID: 6fr294W6TjGXIx8MQ6562w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265266141"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 12:49:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v2 10/14] idpf: print a debug message and bail in case of non-event ctlq message
Date: Fri,  3 Apr 2026 12:49:32 -0700
Message-ID: <20260403194938.3577011-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275191-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82575397EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Larysa Zaremba <larysa.zaremba@intel.com>

Unlike previous internal idpf ctlq implementation, idpf calls the default
message handler for all received messages that do not have a matching xn
transaction, not only for VIRTCHNL2_OP_EVENT. This leads to many error
messages printing garbage, because the parsing expected a valid event
message, but got e.g. a delayed response for a timed-out transaction.

The information about timed-out transactions and otherwise unhandleable
messages can still be valuable for developers, so print the information
with dynamic debug and exit the function, so the following functions can
parse valid events in peace.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 412159bb6259..129c8f6b0faa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -84,6 +84,13 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
 	u32 event;
 
 	adapter = container_of(ctx, struct idpf_adapter, ctlq_ctx);
+	if (ctlq_msg->chnl_opcode != VIRTCHNL2_OP_EVENT) {
+		dev_dbg(&adapter->pdev->dev,
+			"Unhandled message with opcode %u from CP\n",
+			ctlq_msg->chnl_opcode);
+		goto free_rx_buf;
+	}
+
 	if (payload_size < sizeof(*v2e)) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
 				    ctlq_msg->chnl_opcode,
-- 
2.47.1


