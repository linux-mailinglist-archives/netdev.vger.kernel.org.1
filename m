Return-Path: <netdev+bounces-293927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKkjKcogHmrmhQkAu9opvQ
	(envelope-from <netdev+bounces-293927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:16:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E362680E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7923038ADC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CA92C0F6D;
	Tue,  2 Jun 2026 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2PBASoS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E31E885A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359334; cv=none; b=SdL/DYkdScEQjMoDYn1PoBRviUoaKGwfyytuSX3r3gBaeI6Z7x3i5GRj3o85JO5y+n+98YV1zlk7p87WwFyUIXf8AZ1xZ7xN3gkYS0P8g0oXpf8LOEfG5QUh5qj0M3rvQULmmUHJjniElyO8aAXBC9wABlSzbdkbKaNEDySJ0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359334; c=relaxed/simple;
	bh=/W+zCUxirdrhej8rHHCD2mXUReWdw20uF6TAB+6eYdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMOwkDOVLk5io5KN13XP4H6oimzrzbmhIjy5kfg133g2ru70ErQ2GHrkP+NVbdz5hdPorIo4Oi5xlZl7yHfNIZfTwYV6U7vJX+nYc221auwfU4qEjHAt5xvTXQxyllBBbkbpnn9JTKu05GIvWn+Vcw4weOM+ESaQctcla9qP/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2PBASoS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780359332; x=1811895332;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/W+zCUxirdrhej8rHHCD2mXUReWdw20uF6TAB+6eYdk=;
  b=U2PBASoS37MLDFG2txq2yG0Cms9ZOwInpSmiqzdwpn3V39nbROO7Tk9k
   L6nC6n/bZtIM6mLxcKBRJ7kl/sxmbMeEEbUGURnMGH4rzzLaZpB5MCara
   l6tPUh4PfaHqhEtGsM/oG6dbYEY/0I5f4VC3cqCRoXRjW08dvMLAHzOQJ
   VM9L+5dSVdJY+JRlQQv5lPxvqoG7N1bf65r7BBOdSmhAh6a4XFSqi9TWn
   U6cdADk9DeA0zHfBRx+AN65bIWcEex5ac4Q90K0/kFsydRPTl3g7RsfBx
   G0qtgtTDNq77pUjP+i+9s6hF3nT7ZXm2wB5DH0gQPHGmdnfVzn8eolG9a
   g==;
X-CSE-ConnectionGUID: fJO1sHT0SKi/Ktw2XTA+Tg==
X-CSE-MsgGUID: +ptod+SoTKmD5tRS28XwgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84755421"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="84755421"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
X-CSE-ConnectionGUID: DILmV1zDRUKcsbmm/XJQlQ==
X-CSE-MsgGUID: 9cglMLoVR7WKVRcsrLNy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267598719"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 01 Jun 2026 17:14:19 -0700
Subject: [PATCH iwl-next 2/6] ice: count number of VSIS in agg_vsi_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-2-36d6ecbe5ede@intel.com>
References: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
In-Reply-To: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org, Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.16-dev-3fed5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=/W+zCUxirdrhej8rHHCD2mXUReWdw20uF6TAB+6eYdk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhiw5hQU7Lp0QdlicvCV1s6RX08F3WtJHOuaeXrt9n56f/
 43lT96UdZSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRcANGhn77NDbT6hWZx6e2
 2/PcvB150+TEXQ8PQ8n1PcI57fam2xl+s77RuqeXzu0Wo2XCqarze8Up6T0upz83rpYtNy13Kpz
 OAgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293927-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 547E362680E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ice_sched_agg_info structure maintains a list of VSIs associated with
the aggregator node. A following change is going to refactor logic from
ice_lib.c, and remove the ice_agg_node wrapper structure. Doing so will
require keeping track of how many VSIs are on a given aggregator node.

To simplify this tracking, add a member to the ice_sched_agg_info structure
which counts the number of VSIs using the node. Increment it when adding a
VSI to the list, and decrement when removing the VSI from the list. This
will avoid the need to iterate the agg_vsi_list to determine this
information.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.h | 1 +
 drivers/net/ethernet/intel/ice/ice_sched.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index f2a619fcab8b..992aafc4369d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -68,6 +68,7 @@ struct ice_sched_agg_vsi_info {
 struct ice_sched_agg_info {
 	struct list_head agg_vsi_list;
 	DECLARE_BITMAP(tc_bitmap, ICE_MAX_TRAFFIC_CLASS);
+	u32 num_vsis;
 	u32 agg_id;
 	enum ice_agg_type agg_type;
 	/* bw_t_info saves aggregator BW information */
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a74f840cba23..bfca45f5c53c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -823,8 +823,10 @@ void ice_sched_clear_agg(struct ice_hw *hw)
 					 &agg_info->agg_vsi_list, list_entry) {
 			list_del(&agg_vsi_info->list_entry);
 			devm_kfree(ice_hw_to_dev(hw), agg_vsi_info);
+			agg_info->num_vsis--;
 		}
 		xa_erase(&hw->agg_list, index);
+		WARN_ON(agg_info->num_vsis > 0);
 		devm_kfree(ice_hw_to_dev(hw), agg_info);
 	}
 }
@@ -2072,6 +2074,7 @@ static void ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
 				list_del(&agg_vsi_info->list_entry);
 				devm_kfree(ice_hw_to_dev(pi->hw),
 					   agg_vsi_info);
+				agg_info->num_vsis--;
 				return;
 			}
 	}
@@ -2473,6 +2476,7 @@ ice_move_all_vsi_to_dflt_agg(struct ice_port_info *pi,
 		if (rm_vsi_info && !agg_vsi_info->tc_bitmap[0]) {
 			list_del(&agg_vsi_info->list_entry);
 			devm_kfree(ice_hw_to_dev(pi->hw), agg_vsi_info);
+			agg_info->num_vsis--;
 		}
 	}
 
@@ -2728,6 +2732,7 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 
 		/* Initialize the aggregator VSI list head */
 		INIT_LIST_HEAD(&agg_info->agg_vsi_list);
+		agg_info->num_vsis = 0;
 
 		/* Add new entry in aggregator array */
 		status = xa_insert(&hw->agg_list, agg_id, agg_info,
@@ -2915,6 +2920,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 		/* add VSI ID into the aggregator list */
 		agg_vsi_info->vsi_handle = vsi_handle;
 		list_add(&agg_vsi_info->list_entry, &agg_info->agg_vsi_list);
+		agg_info->num_vsis++;
 	}
 	/* Move VSI node to new aggregator node for requested TC(s) */
 	ice_for_each_traffic_class(tc) {
@@ -2933,6 +2939,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 	if (old_agg_vsi_info && !old_agg_vsi_info->tc_bitmap[0]) {
 		list_del(&old_agg_vsi_info->list_entry);
 		devm_kfree(ice_hw_to_dev(pi->hw), old_agg_vsi_info);
+		old_agg_info->num_vsis--;
 	}
 	return status;
 }

-- 
2.54.0.1064.gd145956f57df


