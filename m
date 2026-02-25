Return-Path: <netdev+bounces-261080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJllFc9mn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:17:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40F19DBF5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 411373032DC1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94440267B90;
	Wed, 25 Feb 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVy1GVcD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805730EF63
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054157; cv=none; b=itRupfdiE8p5BQ6W0i638rf6RnR2G0a9nqkV8KawFRfqUV3PSZQNKNj0QY7GrocaatPZOb0aNUV8ekmTrl+dr5B2FxEiFOr9L/PXJ915/eSa7nNyaHxrVSb/D6ItkfYs1/uYNbgpga16qg5M4zE31lpA7/3Gw41wA819aD9f2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054157; c=relaxed/simple;
	bh=UcxmttI3/fPWN5YeNse0zzAKsxiVJgZ3rQajvidjvyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8vsofnWy+WS/ZqoRz8vezQbzd3rogdVkhomkIpDAo6Uhu/kwszcUFo+fgz+k3mKqSrxrHpyS1EOqYeedszevf7xQ77fL1ZiEsrELl/lBrMqxqGYme096uFE1xeR8zW+Yk9lluiF5q8I3Vxn6EqYw6Xd8rCFKgLsOEd4FWTbhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVy1GVcD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054157; x=1803590157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcxmttI3/fPWN5YeNse0zzAKsxiVJgZ3rQajvidjvyg=;
  b=XVy1GVcDUaeAit3jGTd4I99nxXxAxkCPzSgZyY+d631qretkQ/RGmI2a
   bnCStRSlY4y02YIWga8iQ1PvIPDaB2ZHTA76E12bwzCveLEhbpIm0odXx
   upFD5vHYvdz6pXvBSCCjjb4U7I2oW/tXwkodKzjvpWKe6f/XVMOkVA/qg
   pIJXi+eMgsd73UZ23/0fD+NbyVH6fKJTMfZ1dvdhx3OLYebNatHk89jei
   FjoyOmiv58wJcBLMjYrg60S2vImnK/Q0mZuef70Hy4BwmkDGd6T0ednOW
   sC8xWSD+LZnGhsrvQhC9VBLXj44YPqfcSSnqueIynmXV2vmTnwnffHXHl
   w==;
X-CSE-ConnectionGUID: H6W1HGdbQoeeIq+IoBVnAw==
X-CSE-MsgGUID: Mu2T7J8+QOCBDE6EIaLgzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013779"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:55 -0800
X-CSE-ConnectionGUID: BzKa1AM9SaCD13p/uy5K/w==
X-CSE-MsgGUID: /LZrsoI4SMqhPVtlF9VsMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349690"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Li Li <boolli@google.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	sridhar.samudrala@intel.com,
	brianvv@google.com,
	decot@google.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net v2 04/12] idpf: nullify pointers after they are freed
Date: Wed, 25 Feb 2026 13:15:35 -0800
Message-ID: <20260225211546.1949260-5-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261080-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF40F19DBF5
X-Rspamd-Action: no action

From: Li Li <boolli@google.com>

rss_data->rss_key needs to be nullified after it is freed.
Checks like "if (!rss_data->rss_key)" in the code could fail
if it is not nullified.

Tested: built and booted the kernel.

Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early ethtool operations")
Signed-off-by: Li Li <boolli@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 94da5fbd56f1..7ce6a0e4acb6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1320,6 +1320,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 free_rss_key:
 	kfree(rss_data->rss_key);
+	rss_data->rss_key = NULL;
 free_qreg_chunks:
 	idpf_vport_deinit_queue_reg_chunks(adapter->vport_config[idx]);
 free_vector_idxs:
-- 
2.47.1


