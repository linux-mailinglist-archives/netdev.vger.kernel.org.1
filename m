Return-Path: <netdev+bounces-67535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B29843EF8
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FCA293033
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9778689;
	Wed, 31 Jan 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKMg8abu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934778681
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702330; cv=none; b=ftlfC0TbG32B40Ve7YphfxTbJmSIrQqp+D6ehOsF31efHzreuznUzr6LnJgcLcOvFLSq268RBPPO/PtIJkcj1zJx+QzmiKh4nMw6r8YPORe8Mm2btbKdHdQMDTkA9G5SXeOuo7xDrewEgji+50aa2ydxjUAErJT/wux5lSLFJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702330; c=relaxed/simple;
	bh=vQTxKmxNLrOZTQFC03YHyLIxMEQKV5LHoIoefnpdX6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2N89X+HaUisDd2ke1o1fotof9cTp1rOlrT5i9RtfR3gbNWRnh4CVLksUgtk2XunBLRV37VT+zGAOlN6gmssJi2p4iJ7uAL2n+WHn4meWSFpMrv9D2OelrAE/oah9RJGMfpeP3jqTgBljb7NQNI0TyDluQ9/aCJoNAq0BK7nRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKMg8abu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706702327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bSPLZkeIs6KrW4Fjdab8ZXrWS3TSee/NzqB5S6HzDy0=;
	b=WKMg8abuZB/iBY9Nv1cVFR+ciRhJ/MUw8LeoBK5X2hlQ+7LoyByX/LXaV1Akr+bLQYgMO5
	CXYD7cG7pbI08F8n4/UxAd6sygm+TqLGEBf0pU/1Ra+mOgr3D32pam1L8/M6G+9mcsGaJ5
	gFbNlcSN0Z7IPFhrWa+Y1QNKxrJ9C0s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-wpR_xjKSNZeIw4JHerNHiQ-1; Wed,
 31 Jan 2024 06:58:44 -0500
X-MC-Unique: wpR_xjKSNZeIw4JHerNHiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C12243C000AA;
	Wed, 31 Jan 2024 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 474B2492BC6;
	Wed, 31 Jan 2024 11:58:42 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net] ice: fix unaligned access in ice_create_lag_recipe
Date: Wed, 31 Jan 2024 12:58:23 +0100
Message-ID: <20240131115823.541317-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

new_rcp->recipe_bitmap was written to as if it were an aligned bitmap.
It is an 8-byte array, but aligned only to 4.
Use put_unaligned to set its value.

Additionally, values in ice commands are typically in little-endian.
I assume the recipe bitmap should be too, so use the *_le64 conversion.
I don't have a big-endian system with ice to test this.

I tested that the driver does not crash when probing on aarch64 anymore,
which is good enough for me. I don't know if the LAG feature actually
works.

This is what the crash looked like without the fix:
[   17.599009] Unable to handle kernel paging request at virtual address ffff07ff9c6dc004
[   17.599011] Mem abort info:
[   17.599011]   ESR = 0x0000000096000021
[   17.599012]   EC = 0x25: DABT (current EL), IL = 32 bits
[   17.599013]   SET = 0, FnV = 0
[   17.599014]   EA = 0, S1PTW = 0
[   17.599014]   FSC = 0x21: alignment fault
[   17.599015] Data abort info:
[   17.599016]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
[   17.599016]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   17.599017]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   17.599019] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000080dd6bd0000
[   17.599020] [ffff07ff9c6dc004] pgd=1800083fffacf003, p4d=1800083fffacf003, pud=1800083ffface003, pmd=1800083fff9ea003, pte=006808001c6dcf07
[   17.599025] Internal error: Oops: 0000000096000021 [#1] SMP
[   17.599027] Modules linked in: crct10dif_ce ghash_ce sha2_ce sha256_arm64 mlx5_core sha1_ce sbsa_gwdt ice(+) nvme nvme_core mlxfw igb tls nvme_common psample i2c_algo_bit gnss pci_hyperv_intf i2c_designware_platform i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
[   17.599043] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted 5.14.0-407.el9.aarch64 #1
[   17.599044] Hardware name: GIGABYTE R272-P31-00/MP32-AR1-00, BIOS F31L (SCP: 2.10.20220531) 09/29/2022
[   17.599046] Workqueue: events work_for_cpu_fn
[   17.599051] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   17.599053] pc : ice_create_lag_recipe.constprop.0+0xbc/0x11c [ice]
[   17.599091] lr : ice_create_lag_recipe.constprop.0+0x54/0x11c [ice]
[   17.599121] sp : ffff8000084a3c50
[   17.599122] x29: ffff8000084a3c50 x28: ffffabc4a6790f00 x27: ffffabc4a6200fa0
[   17.599124] x26: ffff07ff809e5c34 x25: ffff083e5f41980d x24: ffff07ff8610a0c0
[   17.599126] x23: 0000000000000000 x22: ffff07ff9fe894c0 x21: ffff07ffb771a460
[   17.599128] x20: ffff07ff9c6dc000 x19: 0000000000000000 x18: 0000000000000014
[   17.599130] x17: 00000000c3142fa2 x16: 000000007e77e163 x15: 0000000018c66856
[   17.599132] x14: 00000000b8afd426 x13: 000000007e8b3b19 x12: 000000004a34fdf7
[   17.599134] x11: 00000000a7cb2fcc x10: 00000000ffffff8a x9 : 0000000000000000
[   17.599136] x8 : 0000002000000005 x7 : 0000000000000001 x6 : ffffabc487a054d8
[   17.599138] x5 : ffff07ff9c6dc004 x4 : 000000000000000a x3 : 0000000000000000
[   17.599140] x2 : 0000000000000000 x1 : 0000000000000400 x0 : ffff07ff9c6dc004
[   17.599142] Call trace:
[   17.599143]  ice_create_lag_recipe.constprop.0+0xbc/0x11c [ice]
[   17.599172]  ice_init_lag+0xcc/0x22c [ice]
[   17.599201]  ice_init_features+0x160/0x2b4 [ice]
[   17.599230]  ice_probe+0x2d0/0x30c [ice]
[   17.599258]  local_pci_probe+0x58/0xb0
[   17.599262]  work_for_cpu_fn+0x20/0x30
[   17.599264]  process_one_work+0x1e4/0x4c0
[   17.599266]  worker_thread+0x220/0x450
[   17.599268]  kthread+0xe8/0xf4
[   17.599270]  ret_from_fork+0x10/0x20
[   17.599273] Code: 380044a4 f800429f 8b000ca0 d503201f (f821301f)
[   17.599274] ---[ end trace 168d79e2ecf9f7e3 ]---
[   17.599275] Kernel panic - not syncing: Oops: Fatal exception
[   17.893321] SMP: stopping secondary CPUs
[   17.897374] Kernel Offset: 0x2bc49c400000 from 0xffff800008000000
[   17.903453] PHYS_OFFSET: 0x80000000
[   17.906928] CPU features: 0x0,00000001,70028143,1041720b
[   17.912226] Memory Limit: none
[   17.915268] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 2a25323105e5..d4848f6fe919 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1829,9 +1829,7 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
 	new_rcp->content.act_ctrl_fwd_priority = prio;
 	new_rcp->content.rid = *rid | ICE_AQ_RECIPE_ID_IS_ROOT;
 	new_rcp->recipe_indx = *rid;
-	bitmap_zero((unsigned long *)new_rcp->recipe_bitmap,
-		    ICE_MAX_NUM_RECIPES);
-	set_bit(*rid, (unsigned long *)new_rcp->recipe_bitmap);
+	put_unaligned_le64(BIT_ULL(*rid), new_rcp->recipe_bitmap);
 
 	err = ice_aq_add_recipe(hw, new_rcp, 1, NULL);
 	if (err)
-- 
2.43.0


