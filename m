Return-Path: <netdev+bounces-133761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E951A996FA7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CB62832E2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59B41E1044;
	Wed,  9 Oct 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4HXVmip"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A301E1027
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487045; cv=none; b=LypG+0ce/8DAL/c3ZMFwfXBv6sH6+CPfcbQKMCFjERso4/9aFlN5WyrpIjSCSq2O5oJA1uZyVomDE+f6P0hRhcfB6PNlsNGwchhOyxPvxRDiX1T4OwR8IeTpV5d0ZCssXnYxXMh6In58xJckTYjHhTQj2PP7zr4xdgsjMVEQbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487045; c=relaxed/simple;
	bh=dmk/apIGRnSDL5xBcTWe4gL2fhF7Op6JH5roKVU2tkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVGmFExPGFa3wQb9DyAR6BvxRHRk7IVOwxHZfbtU/ZMvh964P2OAUOh8RW7RN0jFJLqCghUt12/pdW/bS3HqbQiO+FWKBTqdT4DI08207nor+5zZCLDq5RZHKKY1lkbI7xPyT+yrLbf9jq5dH/jyssJ8pX1H67g6fc4AULXV+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4HXVmip; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487044; x=1760023044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dmk/apIGRnSDL5xBcTWe4gL2fhF7Op6JH5roKVU2tkk=;
  b=a4HXVmiph4/dWFoyre6N9mqlawPMTVBUQp2TE8s9WwunfgfYa6FUu9ga
   jU88NT02sf+mlV5o8Y8F0TBD4R4epSOsHZlaq/1VngPvBwx6xhB8xKTz3
   L2wZ1tIoa32kmxD/q2Y0lP/hIY126bnDOMYDqCzXyj1FF0QHZlsNlqS9w
   MR1pV8d940VVbX2mrjtm7PJqpgUKT5AwK17fgPcP/T2rUR/z5gpbChZNr
   BPxrD3u3t3raXhmLt83Lua1korwsnRTGi2yqqfk5B59oFHAOSEahRYtFW
   2VlqL7fHhsLUbQb7lWQhAUmhIrj6GTGw3Nqa+Nn6tjGonmcmFwDB1WTj2
   A==;
X-CSE-ConnectionGUID: BQZ4H6MYTUSOP+8ePiVMyw==
X-CSE-MsgGUID: GbUHnlG3Tt2BUXbNmPJhVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27272942"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27272942"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:17:23 -0700
X-CSE-ConnectionGUID: aB/ciRaIQ8+reIotUQ5HEg==
X-CSE-MsgGUID: 46SAPP+gQheSoruV2rrMsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="76744430"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 09 Oct 2024 08:17:21 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5BEA32FC5B;
	Wed,  9 Oct 2024 16:17:19 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-net v2] ice: Fix use after free during unload with ports in bridge
Date: Wed,  9 Oct 2024 17:18:35 +0200
Message-ID: <20241009151835.5971-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unloading the ice driver while switchdev port representors are added to
a bridge can lead to kernel panic. Reproducer:

  modprobe ice

  devlink dev eswitch set $PF1_PCI mode switchdev

  ip link add $BR type bridge
  ip link set $BR up

  echo 2 > /sys/class/net/$PF1/device/sriov_numvfs
  sleep 2

  ip link set $PF1 master $BR
  ip link set $VF1_PR master $BR
  ip link set $VF2_PR master $BR
  ip link set $PF1 up
  ip link set $VF1_PR up
  ip link set $VF2_PR up
  ip link set $VF1 up

  rmmod irdma ice

When unloading the driver, ice_eswitch_detach() is eventually called as
part of VF freeing. First, it removes a port representor from xarray,
then unregister_netdev() is called (via repr->ops.rem()), finally
representor is deallocated. The problem comes from the bridge doing its
own deinit at the same time. unregister_netdev() triggers a notifier
chain, resulting in ice_eswitch_br_port_deinit() being called. It should
set repr->br_port = NULL, but this does not happen since repr has
already been removed from xarray and is not found. Regardless, it
finishes up deallocating br_port. At this point, repr is still not freed
and an fdb event can happen, in which ice_eswitch_br_fdb_event_work()
takes repr->br_port and tries to use it, which causes a panic (use after
free).

Note that this only happens with 2 or more port representors added to
the bridge, since with only one representor port, the bridge deinit is
slightly different (ice_eswitch_br_port_deinit() is called via
ice_eswitch_br_ports_flush(), not ice_eswitch_br_port_unlink()).

Trace:
  Oops: general protection fault, probably for non-canonical address 0xf129010fd1a93284: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0x8948287e8d499420-0x8948287e8d499427]
  (...)
  Workqueue: ice_bridge_wq ice_eswitch_br_fdb_event_work [ice]
  RIP: 0010:__rht_bucket_nested+0xb4/0x180
  (...)
  Call Trace:
   (...)
   ice_eswitch_br_fdb_find+0x3fa/0x550 [ice]
   ? __pfx_ice_eswitch_br_fdb_find+0x10/0x10 [ice]
   ice_eswitch_br_fdb_event_work+0x2de/0x1e60 [ice]
   ? __schedule+0xf60/0x5210
   ? mutex_lock+0x91/0xe0
   ? __pfx_ice_eswitch_br_fdb_event_work+0x10/0x10 [ice]
   ? ice_eswitch_br_update_work+0x1f4/0x310 [ice]
   (...)

A workaround is available: brctl setageing $BR 0, which stops the bridge
from adding fdb entries altogether.

Change the order of operations in ice_eswitch_detach(): move the call to
unregister_netdev() before removing repr from xarray. This way
repr->br_port will be correctly set to NULL in
ice_eswitch_br_port_deinit(), preventing a panic.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2: Added trace excerpt
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c0b3e70a7ea3..fb527434b58b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -552,13 +552,14 @@ int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
 static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
 {
 	ice_eswitch_stop_reprs(pf);
+	repr->ops.rem(repr);
+
 	xa_erase(&pf->eswitch.reprs, repr->id);
 
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
 
 	ice_eswitch_release_repr(pf, repr);
-	repr->ops.rem(repr);
 	ice_repr_destroy(repr);
 
 	if (xa_empty(&pf->eswitch.reprs)) {
-- 
2.45.0


