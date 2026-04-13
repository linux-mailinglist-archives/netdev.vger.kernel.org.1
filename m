Return-Path: <netdev+bounces-277970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGRYJqSb3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:30:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EF3E83FE
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C6013006F02
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39643932CA;
	Mon, 13 Apr 2026 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efoOBUX+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99023590A4
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065441; cv=none; b=m07dgmhU430XIjOrH2mdkYLExdGVX/n2Iva0WaadNs/p+QlYbOm3bYcWmzFCObvZEGMBlQitg3PTqLmdG9uCwBcTNHge+B8Cxdl3bGqgnLML2iiqPRIKTpOeQ7DKr3qtpM0ALS+tpfCP5on8tZZnc6OT+dVsRf/nCXtZjQn6Cvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065441; c=relaxed/simple;
	bh=ta+v/kaw6mxcspfEY59yn1vMg7wbC7MsZRcrKAktIFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgX2QY/6jsk8OjrHlVnjZlV0rviBoTitn4I1u4YmSx4MzUVeyFgbcrttqUfEdEQIHAm/yju2dhZZby7eMR/W/42q9Rd4vBK68eWceki0rnTp/opdc/cJaHD6hLFpPHztAwQX/29l7+QLs0Nv3lYsrVw10x04XxHg8NyzOfG2zOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efoOBUX+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776065440; x=1807601440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ta+v/kaw6mxcspfEY59yn1vMg7wbC7MsZRcrKAktIFk=;
  b=efoOBUX+tvXfiAwn6/pc5XCW3xrA+/1Fcg4iftu3fEu3sGcWxXbjTdGa
   k/2r2WSi7etGcZVlC23jriVIFFCSGJNpfsxyPt8JFHy5ezbTcjC7e5SSp
   4TA+MufF2rseJdTkeF41Cq0jfOJerEs7e+ssmuXbe/w0wxRvpIeLZYfmz
   Z0tnEo7U3hR0RESIeyUaWYF4OFW+vrEOV5n5Lbb9lKC6pZ4xaLwISQP/V
   ZSnNvA0xy22P6KNABoQD0dl0SkwfDTNl39VEASDubJXUH9HUYxB0ILPqP
   skKmnvPpXzUndTYMAg9Rmq7dUWZxP8o7lNMUHKyTcXAaIGkm9cBz1cKq4
   A==;
X-CSE-ConnectionGUID: D7zXML78TdigNmXFtLgEsQ==
X-CSE-MsgGUID: 2nV50viGR0aPv9y3DWoMBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876623"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="80876623"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 00:30:39 -0700
X-CSE-ConnectionGUID: oIM8odAfTtGc4cdJON8cOA==
X-CSE-MsgGUID: gWIl8THVTPWKhPqHzA5q+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="267700532"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kiran Patil <kiran.patil@intel.com>
Subject: [PATCH iwl-net 1/5] iavf: fix null pointer dereference in iavf_detect_recover_hung
Date: Mon, 13 Apr 2026 09:30:31 +0200
Message-ID: <20260413073035.4082204-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277970-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F19EF3E83FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kiran Patil <kiran.patil@intel.com>

During a concurrent reset, q_vectors are freed and re-allocated while
the watchdog task may still be iterating rings in
iavf_detect_recover_hung(). Dereferencing a NULL q_vector inside
iavf_force_wb() results in a crash. Guard against this by skipping
rings whose q_vector is NULL.

Also move the tx_ring declaration into the loop body and drop the
redundant outer NULL initialisation, which the compiler can never
observe since an array-element address is always non-NULL.

Fixes: 9c6c12595b73 ("i40e: Detection and recovery of TX queue hung logic moved to service_task from tx_timeout")
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 363c42b..e7e7fc9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -176,7 +176,6 @@ static void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
  **/
 void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 {
-	struct iavf_ring *tx_ring = NULL;
 	struct net_device *netdev;
 	unsigned int i;
 	int packets;
@@ -195,8 +194,11 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 		return;
 
 	for (i = 0; i < vsi->back->num_active_queues; i++) {
-		tx_ring = &vsi->back->tx_rings[i];
-		if (tx_ring && tx_ring->desc) {
+		struct iavf_ring *tx_ring = &vsi->back->tx_rings[i];
+
+		if (!tx_ring || !tx_ring->q_vector)
+			continue;
+		if (tx_ring->desc) {
 			/* If packet counter has not changed the queue is
 			 * likely stalled, so force an interrupt for this
 			 * queue.
-- 
2.52.0


