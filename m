Return-Path: <netdev+bounces-136107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE67D9A058C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B3A1F223FE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB001B6D13;
	Wed, 16 Oct 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+BYCjOG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F486199944
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071016; cv=none; b=UZ9CScZa5a2gLG4a2ahQBirRDusxz55zunWQwKzYKuywoPwWc/FU/XyGZZvhOqb3nOI224yHFm4afgVDFMDF/51nyeJ9EQXMEATf6oFapCC9OvkP+yFeUO9C3A0kuN1TB2o+Say6OwliJigV7Q4ii/MvhbCrJSfFJm/hqfH931Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071016; c=relaxed/simple;
	bh=YnnXeh6jcwhPnNEp9hZbToy0o2YfPiF/dNUridaGA/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qHiqRs46KbVYqUIBSFawkly1jDH1PZdPSxSFnCBq0a0YhP4GouUjTnZG8SnbzdfK0MUyQNFwAHHiveNcGkG2lcO859zrWsL0AET4v9W+dK5feG8r6PIpakTSvSHgb/Fmpp/pjgLHIzgb0nZoAPBX+H+Ogr0bWC1mI4guK64oewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+BYCjOG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729071014; x=1760607014;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YnnXeh6jcwhPnNEp9hZbToy0o2YfPiF/dNUridaGA/I=;
  b=I+BYCjOGnCYlQxnX0xjtFUDsfasG5UqTuVO7T7ol/T8SO1RmuXnTlVQb
   xQhmvZ91eiFZS/miUyRk9VbMW3zHL0d6pHLh3RT5BxIhjjyBq8VA39Lm0
   xXPL6BZQjBaRBDxgFGgFMA2iGgIylzjE/0jiJs0hxjqfUxa+o7D3U56oe
   28NBaIHccKcJVFcLX8lOcP9AqQWQ/KCa0pxBwKuscp6No8zL15yCop29S
   wL/FU+TGCEe2RgjeYtpiYnlBL5dHw9bpXwQwzC1NZqy7FsMnNqIE9rTN9
   D1Gf0i+BC+OBPmyD3CftEqxjBL2cUAwW9mCm7Ib91KEzlb5BeHsMLJC33
   g==;
X-CSE-ConnectionGUID: PJm7uO/LTVubNUG7aqmZXQ==
X-CSE-MsgGUID: 26MIeSUtTk2QstVnQkzHVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39880033"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="39880033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 02:30:14 -0700
X-CSE-ConnectionGUID: VBErF9YKQja8vT0EC0jwEQ==
X-CSE-MsgGUID: PrKK+/z3ToiM7/OdhByqeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="77847885"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2024 02:30:12 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2] i40e: fix race condition by adding filter's intermediate sync state
Date: Wed, 16 Oct 2024 11:30:11 +0200
Message-Id: <20241016093011.318078-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a race condition in the i40e driver that leads to MAC/VLAN filters
becoming corrupted and leaking. Address the issue that occurs under
heavy load when multiple threads are concurrently modifying MAC/VLAN
filters by setting mac and port VLAN.

1. Thread T0 allocates a filter in i40e_add_filter() within
        i40e_ndo_set_vf_port_vlan().
2. Thread T1 concurrently frees the filter in __i40e_del_filter() within
        i40e_ndo_set_vf_mac().
3. Subsequently, i40e_service_task() calls i40e_sync_vsi_filters(), which
        refers to the already freed filter memory, causing corruption.

Reproduction steps:
1. Spawn multiple VFs.
2. Apply a concurrent heavy load by running parallel operations to change
        MAC addresses on the VFs and change port VLANs on the host.
3. Observe errors in dmesg:
"Error I40E_AQ_RC_ENOSPC adding RX filters on VF XX,
	please set promiscuous on manually for VF XX".

Exact code for stable reproduction Intel can't open-source now.

The fix involves implementing a new intermediate filter state,
I40E_FILTER_NEW_SYNC, for the time when a filter is on a tmp_add_list.
These filters cannot be deleted from the hash list directly but
must be removed using the full process.

Fixes: 278e7d0b9d68 ("i40e: store MAC/VLAN filters in a hash with the MAC Address as key")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2 change commit title, removed RESERVED state byt request in review
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 12 ++++++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2089a0e..2e205218 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -755,6 +755,8 @@ enum i40e_filter_state {
 	I40E_FILTER_ACTIVE,		/* Added to switch by FW */
 	I40E_FILTER_FAILED,		/* Rejected by FW */
 	I40E_FILTER_REMOVE,		/* To be removed */
+	I40E_FILTER_NEW_SYNC,		/* New, not sent yet, is in
+					   i40e_sync_vsi_filters() */
 /* There is no 'removed' state; the filter struct is freed */
 };
 struct i40e_mac_filter {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index abf624d..208c2f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -89,6 +89,7 @@ static char *i40e_filter_state_string[] = {
 	"ACTIVE",
 	"FAILED",
 	"REMOVE",
+	"NEW_SYNC",
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 25295ae..55fb362 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1255,6 +1255,7 @@ int i40e_count_filters(struct i40e_vsi *vsi)
 
 	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
 		if (f->state == I40E_FILTER_NEW ||
+		    f->state == I40E_FILTER_NEW_SYNC ||
 		    f->state == I40E_FILTER_ACTIVE)
 			++cnt;
 	}
@@ -1441,6 +1442,8 @@ static int i40e_correct_mac_vlan_filters(struct i40e_vsi *vsi,
 
 			new->f = add_head;
 			new->state = add_head->state;
+			if (add_head->state == I40E_FILTER_NEW)
+				add_head->state = I40E_FILTER_NEW_SYNC;
 
 			/* Add the new filter to the tmp list */
 			hlist_add_head(&new->hlist, tmp_add_list);
@@ -1550,6 +1553,8 @@ static int i40e_correct_vf_mac_vlan_filters(struct i40e_vsi *vsi,
 				return -ENOMEM;
 			new_mac->f = add_head;
 			new_mac->state = add_head->state;
+			if (add_head->state == I40E_FILTER_NEW)
+				add_head->state = I40E_FILTER_NEW_SYNC;
 
 			/* Add the new filter to the tmp list */
 			hlist_add_head(&new_mac->hlist, tmp_add_list);
@@ -2437,7 +2442,8 @@ static int
 i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
 			  struct i40e_mac_filter *f)
 {
-	bool enable = f->state == I40E_FILTER_NEW;
+	bool enable = f->state == I40E_FILTER_NEW ||
+		      f->state == I40E_FILTER_NEW_SYNC;
 	struct i40e_hw *hw = &vsi->back->hw;
 	int aq_ret;
 
@@ -2611,6 +2617,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 
 				/* Add it to the hash list */
 				hlist_add_head(&new->hlist, &tmp_add_list);
+				f->state = I40E_FILTER_NEW_SYNC;
 			}
 
 			/* Count the number of active (current and new) VLAN
@@ -2762,7 +2769,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		spin_lock_bh(&vsi->mac_filter_hash_lock);
 		hlist_for_each_entry_safe(new, h, &tmp_add_list, hlist) {
 			/* Only update the state if we're still NEW */
-			if (new->f->state == I40E_FILTER_NEW)
+			if (new->f->state == I40E_FILTER_NEW ||
+			    new->f->state == I40E_FILTER_NEW_SYNC)
 				new->f->state = new->state;
 			hlist_del(&new->hlist);
 			netdev_hw_addr_refcnt(new->f, vsi->netdev, -1);
-- 
2.25.1


