Return-Path: <netdev+bounces-160854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674CCA1BDE2
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC9516E38D
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBF81E7C26;
	Fri, 24 Jan 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7klhw2P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54951DA103
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754342; cv=none; b=ZV1SMHHBhL9W65EAbDA0QL5nOWYmn+E6Qdozs9dI+Ez6vZ7sWv735rb5V+mwPE9PTFWiXa5dncdxVYQdlg3oTn+91gLRg0/uyBV9z2ms/pFsZmnk4STS+4rwHdZXs4UDHzzL+sKZUd07Syt3XSv1I/O38AATBjJG7LeraxqropQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754342; c=relaxed/simple;
	bh=feeTAPxAtgZE5fkK3OWNHler8ZlsQBmjQ9owo5BQKaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp/KaXdn9JSmj8J7E06RaaPt+4mtrqfWPS/57odeVVybh7FcgJTNKyvqitiF75AtbSi6vsgIGxwiMhx0ce4X3L6W4WMIMqVrlKFWsFJElsE66hookYBFHvQHd5ZwtwLYmGhEjy2XrawGXsD41or71HvXxA6dqcjg9IuXPZInnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7klhw2P; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754339; x=1769290339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=feeTAPxAtgZE5fkK3OWNHler8ZlsQBmjQ9owo5BQKaY=;
  b=n7klhw2P1falzorrCT0JrStsenq5djuGh5C/HLtnRqeTYjb9gn7ylxmm
   ydnDWTldJZ1l9jDv6UsdU5JEV4x6lF6MKsnHm4Hte/dfcTFSC0UASveS8
   QlWeeV/f/ybgdFi7Db/d2z4bV6u2uAHqNIMmNH1A+G85K2UNSWNz16CPm
   q10gXNbp4i6TqA/lBBtk3t583wmq3btYrGovUNz9whRlZTQFoM3NbH2XX
   wugfSanau05tDN3R80J5VAQtgkjUovvmfi6PUMtwa1w67jHCSBsMTPjsk
   MA7GMIIJl6QLfGdSPRN9YZEgNOpQnnmBBETczzflQbiVctTuMv9CRd0t1
   g==;
X-CSE-ConnectionGUID: Dokj3Ef9StKbbeG8pGAKMw==
X-CSE-MsgGUID: dVI8hamfTZWh9OCNM7SizQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140381"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140381"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:17 -0800
X-CSE-ConnectionGUID: WjY6VrgrTMixWCXCRztdnQ==
X-CSE-MsgGUID: yPLacua6Tgi1X6nCgq6DCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861076"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:16 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	decot@google.com,
	willemb@google.com,
	rlance@google.com,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 1/8] idpf: add read memory barrier when checking descriptor done bit
Date: Fri, 24 Jan 2025 13:32:03 -0800
Message-ID: <20250124213213.1328775-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

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
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


