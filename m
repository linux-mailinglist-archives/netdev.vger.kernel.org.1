Return-Path: <netdev+bounces-270740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ7tAjCqwWmUUQQAu9opvQ
	(envelope-from <netdev+bounces-270740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:01:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 773422FD846
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 016CF3049E09
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A33E6387;
	Mon, 23 Mar 2026 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9qUKqzj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817343E5EE8
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299536; cv=none; b=cm1N8xEnds09EArRLQSU6ZEUDT3avX4QTvNOe1t8yMEcF4xWGXLpb0AvVlJb64H4I8wO8i0QqZ20O9BZB9454Acr1tqweJ1XDckOfUDgoYYvhvcuufKxPqswb91c2wSNkN0uwUl0LxXXOaPxDAP467jIGBEx3RGC55+udjb6h30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299536; c=relaxed/simple;
	bh=hTVCeUQ/+8R/8c72/aofLe3983HdshwdIE0aNYh+eEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMuseGa//TPF/vwBoFrc0WP+Hdi63pOegOFoTrAURx2joMCIMy/an6CUp08aJYIKpvSDONbrBlZmYrVSOPQtKXx1Bb6p0FcRHRQsC7FooC43O6desOWb50X51k6V6IWAXZMN2B02nywt/lT/L4fjfs8Gp+OqDQA9TNEmBSx0XMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9qUKqzj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299536; x=1805835536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTVCeUQ/+8R/8c72/aofLe3983HdshwdIE0aNYh+eEU=;
  b=R9qUKqzjwLTDpb5UgC6T8UvWL+wrmJp6KHehssZdBRaeVednKjltPeeP
   LuWH/gMZ/gqLQwGo59Uy59YQdh6wFUf4nKb1tGEnPGZwkNApp/lqZHgI0
   Vil2zmK181AY/LpmNI8Pw0Z0IHlI8L3zXVCL0KBN/XVtxTmengrIaTOEh
   uZ47+91mRLPNlU6XN3T0WEEW7JMlZ7azWjOHmkb5XyNCh8fUuYTaKDg4Y
   6ETgV4ohqlX0I+ZQQwGXqUSNCjYPJ40xiwy9KmnzEIGzM0KoRVRt7qBMs
   t+T0Oj5XWD3xLOrm+cUURVIXbrNosUtiD52qsKz2TxO1qGmpzXaxPhP3Z
   w==;
X-CSE-ConnectionGUID: qYJKiBdJS3mQXE4P+kScSw==
X-CSE-MsgGUID: K3gOCyJeQzerxklvMXQv/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75375532"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75375532"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:58:50 -0700
X-CSE-ConnectionGUID: I8sW8+XgT6eqyI8xf1dtng==
X-CSE-MsgGUID: lkzaqeGpRMmgfQEbtqbLPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224114430"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 23 Mar 2026 13:58:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	boolli@google.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 6/6] idpf: only assign num refillqs if allocation was successful
Date: Mon, 23 Mar 2026 13:58:41 -0700
Message-ID: <20260323205843.624704-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
References: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270740-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 773422FD846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joshua Hay <joshua.a.hay@intel.com>

As reported by AI review [1], if the refillqs allocation fails, refillqs
will be NULL but num_refillqs will be non-zero. The release function
will then dereference refillqs since it thinks the refillqs are present,
resulting in a NULL ptr dereference.

Only assign the num refillqs if the allocation was successful. This will
prevent the release function from entering the loop and accessing
refillqs.

[1] https://lore.kernel.org/netdev/20260227035625.2632753-1-kuba@kernel.org/

Fixes: 95af467d9a4e3 ("idpf: configure resources for RX queues")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 252259993022..f6b3b15364ff 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1860,13 +1860,13 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 			idpf_queue_assign(HSPLIT_EN, q, hs);
 			idpf_queue_assign(RSC_EN, q, rsc);
 
-			bufq_set->num_refillqs = num_rxq;
 			bufq_set->refillqs = kcalloc(num_rxq, swq_size,
 						     GFP_KERNEL);
 			if (!bufq_set->refillqs) {
 				err = -ENOMEM;
 				goto err_alloc;
 			}
+			bufq_set->num_refillqs = num_rxq;
 			for (unsigned int k = 0; k < bufq_set->num_refillqs; k++) {
 				struct idpf_sw_queue *refillq =
 					&bufq_set->refillqs[k];
-- 
2.47.1


