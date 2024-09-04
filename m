Return-Path: <netdev+bounces-124948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47B96B707
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C431F22D6F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E551CEEA9;
	Wed,  4 Sep 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWQ0fKvP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9701CDA0C
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442802; cv=none; b=bSFQy8D8a1S/A8HXS0N4kH/wvom0DZg56M9LAY38WXg1J4qN0ssNma0fbC3bmOQ62dzCr2ncIhHQZ8nwM0ETc8Xv1Gi5VFbaKE1EWds0rmvROff6N21xnc7Vg1RDwwYPfuXJ0ZK7CnRZb/SE6hcG9a608Zkh4nPx/0zE/hmS/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442802; c=relaxed/simple;
	bh=BrIwzAIyfCZk/juxHhZ+m7U4Kfgm9cdIXvoqtr3prmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYzp4Dopg6iaJ4JO4zKB3k3SPXmB3eCMFvlkGi1J3381ufZhqE5tnrFpJo49LQV9D8CUjVPuUTqA/c7GOJ3PlZG3qwl9G+Es3EoMyi4KAKpRM7FGsRuOHuhl+qL4lphekySVqJGwjqU9sqd/HEHtMUwFAC6ycGknMG9TIFe5Kco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWQ0fKvP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725442799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7W9oltKFXttPL8GJSRJ98yRABp613Ij+tZra8U77GSo=;
	b=HWQ0fKvPIIiYn9cTBty/u1FWHsZk+nXFs9ZfhNlcgmihkbEnLo+s1+1sWrrJ3jC1W8ZcIX
	HjCfDqCtcqAnxxU1LaOeXKtROf+c+qE4gz/xdnE9vjyM6HAaKHiCoUz4xVRrTeL3d3b4gz
	dsRajX8J0MG5dPnj7QkR+GID/ECtdzU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-oxcLcZgzPCyf0KdeXNAYhA-1; Wed,
 04 Sep 2024 05:39:54 -0400
X-MC-Unique: oxcLcZgzPCyf0KdeXNAYhA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71D2A195608B;
	Wed,  4 Sep 2024 09:39:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.188])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D00A19560AA;
	Wed,  4 Sep 2024 09:39:44 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@intel.com>,
	Timothy Miskell <timothy.miskell@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Daniel Machon <daniel.machon@microchip.com>
Cc: Petr Oros <poros@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: fix VSI lists confusion when adding VLANs
Date: Wed,  4 Sep 2024 11:39:22 +0200
Message-ID: <20240904093924.24368-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
- trust is turning on on VF2, VF2 is resetting, all filters from VF2 are
  removed; the VLAN 100 filter is also removed because 3 is on the list
- VLAN traffic to VF1 isn't working anymore, there is a need to recreate
  VLAN interface to readd VLAN filter

One thing I'm not certain about is the implications for the LAG feature,
which is another caller of ice_find_vsi_list_entry. I don't have a
LAG-capable card at hand to test.

Fixes: 23ccae5ce15f ("ice: changes to the interface with the HW and FW for SRIOV_VF+LAG")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
v2: Corrected the Fixes commit ID (the ID in v1 was of a centos-stream-9
    backport accidentally).
    Added the extended explanation from Michal Swiatkowski.
    Fixed some typos.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index fe8847184cb1..4e6e7af962bd 100644
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
2.45.2


