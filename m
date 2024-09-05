Return-Path: <netdev+bounces-125469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1A96D2E4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95001B208C5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143F194A60;
	Thu,  5 Sep 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjbvTy3R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D43F9D5
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527656; cv=none; b=So16o+HJqJyquTHd+XceiBmIGFbb2haG5/bI1hlQkhMIOgOEJU4rTJaYAi0aM39/kTxJh4fF2hn6vb2HzG5j26cMf/IaAPz6n6hyhS7OMCmYu6sa+4pqHkku68IbPaZaqPD3LWqiGp+RZv9y39cc4Y6w5k3TrdGFLQCl5m3S3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527656; c=relaxed/simple;
	bh=awy5tMWWrj15MgcU70e/RZ7p4BgVYMs1FLyw7E15Tz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0aDGHmP4QKBEQhlxPkVMI3mJtJSI6TDJLHYadb93ZO7h5YgQT3//M5KZ7fB9ue37zQB+Tn0zN4aC9zJOz3UUcN802dbklJKrfR7MecU2mehteajGDtJQZculPmG1zdDDMcLpAPoXIa85351QKGSknYsTRuheH2/FJnWRNyeskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjbvTy3R; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725527654; x=1757063654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=awy5tMWWrj15MgcU70e/RZ7p4BgVYMs1FLyw7E15Tz4=;
  b=YjbvTy3RkICzbaHuvFdFW/NBFfcBxpmB5CkiN9Ja5sG1LSvpCZ8A2s83
   x5V923OwNiqOG+TYEqLllivICUoh+5tAFBEfV6kasFTzEGNMSAINn0d0P
   aA9+dtUs4Qali3hm2LBLRevnTqnU3lDM7h6jY4TIM/AdZ3kwHYQmacu/D
   J+Y9uEEJg6wIEe3Th6EfIg3PxdAHGLOc6mAxXS6usbUjpiQLtBMfQfCXP
   aJLXShFyJ2sDdHLMbAn9cFhFpkbQ860zLgl1btavK87Bgp4L348VOlAPx
   06AXgaiYp8Lo4vZfw4lQ+3ajw5XrSShzLxxdLgl3VOzl1otkLiJpU1lsn
   A==;
X-CSE-ConnectionGUID: ymC6Z3GAQ++aA9Gkym7YIQ==
X-CSE-MsgGUID: 4x+alDysQwe0XkY+iOxRAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24392683"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24392683"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 02:14:13 -0700
X-CSE-ConnectionGUID: QOzOCvNASQKEJM2Gp4v7Wg==
X-CSE-MsgGUID: JVJcBi6BRJCbDlcH9Kgb3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70351636"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 05 Sep 2024 02:14:11 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	wojciech.drewek@intel.com,
	mschmidt@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: [iwl-net v2] iavf: allow changing VLAN state without calling PF
Date: Thu,  5 Sep 2024 11:14:10 +0200
Message-ID: <20240905091410.26909-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First case:
> ip l a l $VF name vlanx type vlan id 100
> ip l d vlanx
> ip l a l $VF name vlanx type vlan id 100

As workqueue can be execute after sometime, there is a window to have
call trace like that:
- iavf_del_vlan
- iavf_add_vlan
- iavf_del_vlans (wq)

It means that our VLAN 100 will change the state from IAVF_VLAN_ACTIVE
to IAVF_VLAN_REMOVE (iavf_del_vlan). After that in iavf_add_vlan state
won't be changed because VLAN 100 is on the filter list. The final
result is that the VLAN 100 filter isn't added in hardware (no
iavf_add_vlans call).

To fix that change the state if the filter wasn't removed yet directly
to active. It is save as IAVF_VLAN_REMOVE means that virtchnl message
wasn't sent yet.

Second case:
> ip l a l $VF name vlanx type vlan id 100
Any type of VF reset ex. change trust
> ip l s $PF vf $VF_NUM trust on
> ip l d vlanx
> ip l a l $VF name vlanx type vlan id 100

In case of reset iavf driver is responsible for readding all filters
that are being used. To do that all VLAN filters state are changed to
IAVF_VLAN_ADD. Here is even longer window for changing VLAN state from
kernel side, as workqueue isn't called immediately. We can have call
trace like that:

- changing to IAVF_VLAN_ADD (after reset)
- iavf_del_vlan (called from kernel ops)
- iavf_del_vlans (wq)

Not exsisitng VLAN filters will be removed from hardware. It isn't a
bug, ice driver will handle it fine. However, we can have call trace
like that:

- changing to IAVF_VLAN_ADD (after reset)
- iavf_del_vlan (called from kernel ops)
- iavf_add_vlan (called from kernel ops)
- iavf_del_vlans (wq)

With fix for previous case we end up with no VLAN filters in hardware.
We have to remove VLAN filters if the state is IAVF_VLAN_ADD and delete
VLAN was called. It is save as IAVF_VLAN_ADD means that virtchnl message
wasn't sent yet.

Fixes: 0c0da0e95105 ("iavf: refactor VLAN filter states")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v2: https://lore.kernel.org/netdev/20240904120052.24561-1-michal.swiatkowski@linux.intel.com/
 * add missing state in case of delete
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ff11bafb3b4f..3eae0a456e86 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -773,6 +773,11 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		f->state = IAVF_VLAN_ADD;
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
+	} else if (f->state == IAVF_VLAN_REMOVE) {
+		/* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
+		 * We can safely only change the state here.
+		 */
+		f->state = IAVF_VLAN_ACTIVE;
 	}
 
 clearout:
@@ -793,8 +798,18 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 
 	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
-		f->state = IAVF_VLAN_REMOVE;
-		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
+		/* IAVF_ADD_VLAN means that VLAN wasn't even added yet.
+		 * Remove it from the list.
+		 */
+		if (f->state == IAVF_VLAN_ADD) {
+			list_del(&f->list);
+			kfree(f);
+			adapter->num_vlan_filters--;
+		} else {
+			f->state = IAVF_VLAN_REMOVE;
+			iavf_schedule_aq_request(adapter,
+						 IAVF_FLAG_AQ_DEL_VLAN_FILTER);
+		}
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-- 
2.42.0


