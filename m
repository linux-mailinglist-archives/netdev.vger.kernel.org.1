Return-Path: <netdev+bounces-146758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A479D58E7
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 05:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B2283BEE
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621951632E2;
	Fri, 22 Nov 2024 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KX5CCQNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64F145A03
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250487; cv=none; b=Vsh8G16I0whwg/AXj2f0HTdTbODEgPCQjERl8DpYiQkNVewe3DLoJwHlMB9pbsAotm8sag+DWfm+h1oKD2iY6smpRrDEfjjEf/lFMP9JyuYyiM6ae8HYk9/wie2IsjKeYB0EdQs2z+OtFMNu0/8q5AETTVFqpzCVxMWS461ok8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250487; c=relaxed/simple;
	bh=L091Ee2oV55tdzPagKshwB9ShTETaAJtaakuZ26vPUQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=to/sFAgJNMX2x4B1dRlXA3RnRf1XpsIWLPhsBOFcS3KwV8eKaJ3E600eE179Hwe3+mhX0Z5waqaAcGXz2yNFPN1majc+Bx+1Ob9MRQcOjeyveRjgTszrdUNUaMZ6XiVsgZxsX6pLkpgr4k0VlZmPqm2tUNQjNh01xtkJ4uDq7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KX5CCQNZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732250485; x=1763786485;
  h=from:to:cc:subject:date:message-id;
  bh=L091Ee2oV55tdzPagKshwB9ShTETaAJtaakuZ26vPUQ=;
  b=KX5CCQNZ9bbVRURbeflte2+rOFltw3qDEXvEvW6tK61NcMAbeUpgDCSE
   jDfZaMYR7J7UoLjUEibwI4N7YspUymDiFm0WZLZgyC7/7kvLm1bbKvD2h
   qBNyxIHdW0q2Lcdcg8nN4M6mg+wXThZ8vlpMpX5XpRNPJtWGvS+Kwnmoz
   ncFDKjifXG99RMLVjMRWdybtAI119zMVHJTWzqUUwrB5J5YZU3oJd7Pqy
   djUu16TYgEkdv8eHpWWBAOTBMyyjtVcEP/9DezUxsaIf1vTqfBl3dBpQ2
   p3ZXz2Qioe7UarE1sJ+St1knnJQN3MyrXi/Xkb2O+EgKn7HTRNZPfB7Wo
   g==;
X-CSE-ConnectionGUID: RP+yfT77SqmAX2uKu8RRGg==
X-CSE-MsgGUID: ZgwDktUjT1mz9P2oC3/mcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32251402"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="32251402"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 20:41:25 -0800
X-CSE-ConnectionGUID: eZ02IdRWQoyH2f70A6/fZw==
X-CSE-MsgGUID: lkW0hzLUQpue7IcilY78Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="90265730"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa007.fm.intel.com with ESMTP; 21 Nov 2024 20:41:24 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	rlance@google.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com
Subject: [PATCH iwl-net v2] idpf: add read memory barrier when checking descriptor done bit
Date: Thu, 21 Nov 2024 20:40:59 -0800
Message-Id: <20241122044059.20019-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Add read memory barrier to ensure the order of operations when accessing
control queue descriptors. Specifically, we want to avoid cases where loads
can be reordered:

1. Load #1 is dispatched to read descriptor flags.
2. Load #2 is dispatched to read some other field from the descriptor.
3. Load #2 completes, accessing memory/cache at a point in time when the DD
   flag is zero.
4. NIC DMA overwrites the descriptor, now the DD flag is one.
5. Any fields loaded before step 4 are now inconsistent with the actual
   descriptor state.

Add read memory barrier between steps 1 and 2, so that load #2 is not
executed until load #1 has completed.

Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Suggested-by: Lance Richardson <rlance@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
Changelog
v2:
- Rewrote comment to fit on a single line
- Added new line as separator
- Updated last sentence in commit message to include load #
v1:
https://lore.kernel.org/intel-wired-lan/20241115021618.20565-1-emil.s.tantilov@intel.com/
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index 4849590a5591..b28991dd1870 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -376,6 +376,9 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 		if (!(le16_to_cpu(desc->flags) & IDPF_CTLQ_FLAG_DD))
 			break;
 
+		/* Ensure no other fields are read until DD flag is checked */
+		dma_rmb();
+
 		/* strip off FW internal code */
 		desc_err = le16_to_cpu(desc->ret_val) & 0xff;
 
@@ -563,6 +566,9 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 		if (!(flags & IDPF_CTLQ_FLAG_DD))
 			break;
 
+		/* Ensure no other fields are read until DD flag is checked */
+		dma_rmb();
+
 		q_msg[i].vmvf_type = (flags &
 				      (IDPF_CTLQ_FLAG_FTYPE_VM |
 				       IDPF_CTLQ_FLAG_FTYPE_PF)) >>
-- 
2.17.2


