Return-Path: <netdev+bounces-133678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A529B996AB2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524AD1F22A37
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AD199FDA;
	Wed,  9 Oct 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iq6gn0lR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC2197A98
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477975; cv=none; b=mBcW6LM6EK9CwHeZ+qFIqe037RbwJ0myAsozcp9tinGWLwX9TFTzacG7UUPJrnHCytkV1NeZbQcjBkVQRE+ZptQhwGgme3ErxkM6Loz+Rz7e6yD3/9BL4woLMooCsuPMoEmBUG9w7pnqQ4KvBIbACiPMpnYyuCXtv7yg4JAeTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477975; c=relaxed/simple;
	bh=FJ82jUYIaMAoHpd7HZHgd374WFsVyl57GTMYJb7O/tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8dBY5mltMUrFD8Of0IveI6Q/u6wUhcSKk7hGsrX8ba7mpXyg8GZSNkrALuZpBwJXV+ChiZf/KRvP4VUM22fhzW2AACAi7uvSWaPTtvi/+O57X+EhK6d64a3wOukxAr2L6zntS1nsyg0kw0SW2Cn+H/f6+cBURUweH4+v9XizuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iq6gn0lR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728477973; x=1760013973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FJ82jUYIaMAoHpd7HZHgd374WFsVyl57GTMYJb7O/tw=;
  b=iq6gn0lRUDjWZlDaEgCxsJyvTz5jmshWmXzESnXDJGlor6KTRD1UaCHq
   FHp080qbd20uNZkqqbwfMoxorg6rkB9Um/YKOyOsuvUUihW7r05UimvMa
   kKBEKB8UhS+GD9We4cvcrg3wkMCb6O5mTw+c/6zryjJeCoiI6IkON15Hy
   6+Jsg8d4YU1QdH+KN1yC/83nVkDIUjyRxCjk91HodtUFNYrMzT4h3EX8L
   5nqiJ0kFk1DjG+GpAc2qJy82eEh+L8aPyHVeByQ1Uc0S6Z19YO8PS8N2+
   CikuX9aDOrRzFxQHEWu36nhZnyaQYkH1txzq8V0LuXZVrn8OvAbWIyEQJ
   w==;
X-CSE-ConnectionGUID: kfjZiwEoRKSGQktfqijnhg==
X-CSE-MsgGUID: Qb6a4x7hQ2mGYN0FAEi3Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45241188"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45241188"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:46:13 -0700
X-CSE-ConnectionGUID: QC3WmvJjQRCsXM3siUSuFw==
X-CSE-MsgGUID: gGEiIZb0St+khCqQIFHqsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="77060050"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 09 Oct 2024 05:46:12 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 03A1E28791;
	Wed,  9 Oct 2024 13:46:10 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net] ice: Fix use after free during unload with ports in bridge
Date: Wed,  9 Oct 2024 14:49:13 +0200
Message-ID: <20241009124912.9774-2-marcin.szycik@linux.intel.com>
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

A workaround is available: brctl setageing $BR 0, which stops the bridge
from adding fdb entries altogether.

Change the order of operations in ice_eswitch_detach(): move the call to
unregister_netdev() before removing repr from xarray. This way
repr->br_port will be correctly set to NULL in
ice_eswitch_br_port_deinit(), preventing a panic.

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
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


