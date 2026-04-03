Return-Path: <netdev+bounces-274883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLFNOShTz2kCvQYAu9opvQ
	(envelope-from <netdev+bounces-274883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29439127E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35C06304B297
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471E358375;
	Fri,  3 Apr 2026 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipfFvdMt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DF30C632
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194834; cv=none; b=qttNDgleqDTYv7nmL/B7FXeWnbdAgJMkrXlLudFO1ZFSS8rzm+lWmgPC5n2Vy+gOn0TPdUkRmCF/q+Lnqrw7dZWONdn8HiTy4TXiZu18RuqbGcm3bpYvxUaRq4FWnVgt0JBdXSi3CXepaZdCDMUPhWJBwsumA/4zYyCX2vpypJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194834; c=relaxed/simple;
	bh=Vp8t693MvIq+MfKl2r5GIw4QU1Y/T0mo5MRMbiHbG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ3POVFAjhULEWg7/0gRSHtCy9el+DEfTgGGBAhNAwSDIo35r6QmRyEX6wkJ1W8MN0t72daN77kGZF001NINGIuCgPHJ08wnoSOhIeEsBE4MgMjmTK0w8ZQ9RXtrTxBs6tVKLubwK3WzKxkTuVToorAIOnkpEC0X997ydzfRKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipfFvdMt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194833; x=1806730833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vp8t693MvIq+MfKl2r5GIw4QU1Y/T0mo5MRMbiHbG4c=;
  b=ipfFvdMtnW6V3wsswYxm1Jnzzqj30lArkmSQZLod/IPv6ZiBd6zDcK44
   kEfrCLA1y0mktWab47VTHIBiROuiTparMicdzRNMsB312wMi1YtbHhnJ4
   orzKxJFFWx2kaMBcvsgebHgihy/4x6v9OvqtY0UdAtMhEaF4zfTL9cGnn
   vymq16j2OVnQfUOu7pjZhD+A8xIwwigJg8fA7xeMQJfCUgeK85uOgSXtx
   5ygq8ZfHxo6AwoPmZF/XDeMK8qziAWD4kRhUZ1u7C9bR1JLoWlwuOLSDC
   XaISNBnmnizrauv4k4o2IVkiDRv/EFNLPzrDhpnIARkg7A+5dCyBKWhg8
   A==;
X-CSE-ConnectionGUID: WvPTDJzbTrWbwiawE2HicQ==
X-CSE-MsgGUID: 7vlgbJ9gQ7K/gmHIQFQb2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981739"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981739"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:33 -0700
X-CSE-ConnectionGUID: jbTBlcg1SAetYI2QwXajeg==
X-CSE-MsgGUID: 2xE0J/kwReG74IUN0Bb3lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904913"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:31 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@intel.com>
Subject: [PATCH iwl-net 1/10] ice: fix mirroring to VSI list
Date: Fri,  3 Apr 2026 07:40:19 +0200
Message-ID: <20260403054029.3789616-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274883-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F29439127E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Rules whose action can be "to VSI list" should have VSI count set to 1
after creation. There was a lack of it in case of mirroring action. Fix
it by setting correct VSI count also for mirror rules.

Reproduction:
  tc filter add dev eth5 ingress protocol arp prio 6301 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress mirror dev eth9
  tc filter add dev eth5 ingress protocol arp prio 6201 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress mirror dev eth10

  tc filter del dev eth5 prio 6301 ingress

The last command removes the rule, but should only remove one VSI from
the forward list. Without the fix:

  tc filter del dev eth5 prio 6201 ingress

results in an error during removing the rule.

Fixes: aa4967d8529c ("ice: Add support for packet mirroring using hardware in switchdev mode")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index a3e93b1..d77c188 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -7318,7 +7318,8 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	sw->recp_list[rid].adv_rule = true;
 	rule_head = &sw->recp_list[rid].filt_rules;
 
-	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI)
+	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
+	    rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET)
 		adv_fltr->vsi_count = 1;
 
 	/* Add rule entry to book keeping list */
-- 
2.52.0

