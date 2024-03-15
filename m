Return-Path: <netdev+bounces-80057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EC087CBD8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 12:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967F7283B87
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00C1AAD0;
	Fri, 15 Mar 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxzKeDRq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FA19BA2
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500637; cv=none; b=RlTn3dDQDqhRmxkvYC53OUt1K6fxfANWpm3xCP7ps3CGwdmcco4FXKBmF9bq81GIz9xbT527+H8rNSt+Fe55KYxEAhM9+RQvo3ykJwUwB6wh4BSdLcSdekXJwj1xggey0zDVCl0mErXcEk3qfvQ6r3Q84m6p2ryOBDB0Ea8iKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500637; c=relaxed/simple;
	bh=f1y5+s38KG4eul9EBArMIcDOgPDGpTwExT1UYJ9aTiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKXA9Qs6YOKxN5kP9QJIWi7s7HWIXhn7ct5fla82JXyPUpLCLQAvd9wDG9MNYMxPDPimXlqDonlNVDt9AewEr6SnpHE/bfKadpjd40uc9XEdSZ7XkpHcajJ/y714T/YawPJKLhh8dL0jkEtroJlnUPnH6EuJ4caIUFGV5yagf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxzKeDRq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710500636; x=1742036636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f1y5+s38KG4eul9EBArMIcDOgPDGpTwExT1UYJ9aTiM=;
  b=JxzKeDRqj6+xo7dvnYzzKLYdLHliQkfSz/koKgcRYQQ9JDZr6wkRM8re
   lPleCHEfMXohvun7H5k+MwxudicRJg3g0ZZ5sA7QiFAVPi9vOeMgwrJyj
   iKL49u/bKjG2R+tstdVV/SqfiiJfYW33dRhNQJbFsDfnVwba/qEGd9di6
   b/Ztr5EHEWlUaXuFfEtNkSrAvl8zF0aMksKaqUTeY0RJGeeVZv/Yi8FXb
   ltqWWQs/9ZN8z5qCa08+jHKnkc+I51S8EhSiFztmjcZ1c5VX21NFo71vk
   ST7sgoKdyXGPVFEqywTSy1KGrK7mZbVeGaqs/ykZ8gkQyi4hfyTFo244v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5549444"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5549444"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="35761201"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 04:03:54 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [iwl-net v1 2/2] ice: tc: allow zero flags in parsing tc flower
Date: Fri, 15 Mar 2024 12:08:21 +0100
Message-ID: <20240315110821.511321-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240315110821.511321-1-michal.swiatkowski@linux.intel.com>
References: <20240315110821.511321-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for flags is done to not pass empty lookups to adding switch
rule functions. Since metadata is always added to lookups there is no
need to check against the flag.

It is also fixing the problem with such rule:
$ tc filter add dev gtp_dev ingress protocol ip prio 0 flower \
	enc_dst_port 2123 action drop
Switch block in case of GTP can't parse the destination port, because it
should always be set to GTP specific value. The same with ethertype. The
result is that there is no other matching criteria than GTP tunnel. In
this case flags is 0, rule can't be added only because of defensive
check against flags.

Fixes: 9a225f81f540 ("ice: Support GTP-U and GTP-C offload in switchdev")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index a8c686ecd1a0..f8df93e1a9de 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -779,7 +779,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	int ret;
 	int i;
 
-	if (!flags || (flags & ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT)) {
+	if (flags & ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported encap field(s)");
 		return -EOPNOTSUPP;
 	}
-- 
2.42.0


