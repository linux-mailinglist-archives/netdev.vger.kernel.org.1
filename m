Return-Path: <netdev+bounces-126701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7609723DC
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32019B235B9
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C318C33D;
	Mon,  9 Sep 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUQXLPWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E218B464
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914351; cv=none; b=CIqeS3QgGWHrtGI1GsdInd+uhQqE41F1j2rp8hF1NiPMSO7PsDbRdpeN6QQ3VB/ddv7Zh1oz9Rlatf/9ja+J277PyXhB8PC2Vm525mUPsr3IrbNU+ZsTUNNx6pBSuJyT4/+JCHwxf0VRsb23cwlymwg1wHpGjWWMQp5HGSf5yA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914351; c=relaxed/simple;
	bh=2x928nSXQXV7uj/gf/2to7Leksq1hlurQB5fQK9gzec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZRo9L47L5WALz+g1Q034hy9N1Q+AopvFdpghyj3IljhkAuHP+GLzQYWbhzjoop0QnVIVwArbHajFCWh7ncrAXuHe4px34bD4NxT8uEtjrLJkB3XaiulxJ9dKXjKSeUgqLkdlUL3z5N2fP5ZpzJ+x0cv5wLgsr+GE/x837cQgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUQXLPWZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914349; x=1757450349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2x928nSXQXV7uj/gf/2to7Leksq1hlurQB5fQK9gzec=;
  b=KUQXLPWZCxy2xTlf99CsDW6MOG1oFChysCN3Ix3YdfIc/bGD6ie6AkQu
   UDLl6IqN6KQgcnhsLjB3Xz3lyS7CoOV2O6Wy1hMsyGIsROL2u42a9OmCr
   5RuXh3/KbDF0DywM+BzcoTcBiKyrHy0wfuN/5Yf1xPtgb9axQ4caM4Qnj
   ikQooXDOIHolkOdGsfTFxknjHc21s3TSo/Dyp/ESONaHGW5nbNStV/MAN
   6ZefkzOSuAFWPutkZFhDQR6nfn2hX6lB5ze23r/GHAaQAy1aiK0qrCyXC
   UI1hph7hl5azUeOxRz8oeyLKTqUnkk8UO5Wf/QE8ATPc+Iq4If4J/zdK7
   Q==;
X-CSE-ConnectionGUID: ZkOKEFjNQt6Eul3L8UikmA==
X-CSE-MsgGUID: TiLBMvZ8QFagD7xmAkhpug==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24787138"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24787138"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:39:01 -0700
X-CSE-ConnectionGUID: X8bxScrZQvqm+coH4liDPw==
X-CSE-MsgGUID: Pl85G7R2SFq6Lk7wzKU96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67054822"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2024 13:38:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Dave Ertman <David.m.ertman@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/5] ice: fix VSI lists confusion when adding VLANs
Date: Mon,  9 Sep 2024 13:38:40 -0700
Message-ID: <20240909203842.3109822-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
References: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

The description of function ice_find_vsi_list_entry says:
  Search VSI list map with VSI count 1

However, since the blamed commit (see Fixes below), the function no
longer checks vsi_count. This causes a problem in ice_add_vlan_internal,
where the decision to share VSI lists between filter rules relies on the
vsi_count of the found existing VSI list being 1.

The reproducing steps:
1. Have a PF and two VFs.
   There will be a filter rule for VLAN 0, referring to a VSI list
   containing VSIs: 0 (PF), 2 (VF#0), 3 (VF#1).
2. Add VLAN 1234 to VF#0.
   ice will make the wrong decision to share the VSI list with the new
   rule. The wrong behavior may not be immediately apparent, but it can
   be observed with debug prints.
3. Add VLAN 1234 to VF#1.
   ice will unshare the VSI list for the VLAN 1234 rule. Due to the
   earlier bad decision, the newly created VSI list will contain
   VSIs 0 (PF) and 3 (VF#1), instead of expected 2 (VF#0) and 3 (VF#1).
4. Try pinging a network peer over the VLAN interface on VF#0.
   This fails.

Reproducer script at:
https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/test-vlan-vsi-list-confusion.sh
Commented debug trace:
https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/ice-vlan-vsi-lists-debug.txt
Patch adding the debug prints:
https://gitlab.com/mschmidt2/linux/-/commit/f8a8814623944a45091a77c6094c40bfe726bfdb
(Unsafe, by the way. Lacks rule_lock when dumping in ice_remove_vlan.)

Michal Swiatkowski added to the explanation that the bug is caused by
reusing a VSI list created for VLAN 0. All created VFs' VSIs are added
to VLAN 0 filter. When a non-zero VLAN is created on a VF which is already
in VLAN 0 (normal case), the VSI list from VLAN 0 is reused.
It leads to a problem because all VFs (VSIs to be specific) that are
subscribed to VLAN 0 will now receive a new VLAN tag traffic. This is
one bug, another is the bug described above. Removing filters from
one VF will remove VLAN filter from the previous VF. It happens a VF is
reset. Example:
- creation of 3 VFs
- we have VSI list (used for VLAN 0) [0 (pf), 2 (vf1), 3 (vf2), 4 (vf3)]
- we are adding VLAN 100 on VF1, we are reusing the previous list
  because 2 is there
- VLAN traffic works fine, but VLAN 100 tagged traffic can be received
  on all VSIs from the list (for example broadcast or unicast)
- trust is turning on VF2, VF2 is resetting, all filters from VF2 are
  removed; the VLAN 100 filter is also removed because 3 is on the list
- VLAN traffic to VF1 isn't working anymore, there is a need to recreate
  VLAN interface to readd VLAN filter

One thing I'm not certain about is the implications for the LAG feature,
which is another caller of ice_find_vsi_list_entry. I don't have a
LAG-capable card at hand to test.

Fixes: 23ccae5ce15f ("ice: changes to the interface with the HW and FW for SRIOV_VF+LAG")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Dave Ertman <David.m.ertman@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0160f0bae8d6..79d91e95358c 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3264,7 +3264,7 @@ ice_find_vsi_list_entry(struct ice_hw *hw, u8 recp_id, u16 vsi_handle,
 
 	list_head = &sw->recp_list[recp_id].filt_rules;
 	list_for_each_entry(list_itr, list_head, list_entry) {
-		if (list_itr->vsi_list_info) {
+		if (list_itr->vsi_count == 1 && list_itr->vsi_list_info) {
 			map_info = list_itr->vsi_list_info;
 			if (test_bit(vsi_handle, map_info->vsi_map)) {
 				*vsi_list_id = map_info->vsi_list_id;
-- 
2.42.0


