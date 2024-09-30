Return-Path: <netdev+bounces-130638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46998AFF0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53842283951
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE8718C35B;
	Mon, 30 Sep 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntdX97rc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CF188A1A
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735769; cv=none; b=D0X0dd2NSiSorUrkJy7+dqaKky1EX6GXVQahxYmhmbW0kWl82h5yhLVDeG0KuIDPoj2SWEzRuyxUmJ9cKwzH7ghNQbSmLkZR14CRzltMaP7P6nsXrtCaMOLvFZnUcMmU0lA+x1CyAkqir/Q2SabJFtH0Cml2cJSGHas/rnvN7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735769; c=relaxed/simple;
	bh=PS9nIrBKXKXl2LyWoaHKQPTE1UYeJftI22u4tb9Q4/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqbOTnuXgX15N/Z+L0r4aiQ0OpDGNj0w6+4IrrVjuCjwnrX5HQHUj0478/eqFaomjnkz3rbyJYKoSlvEQTfiuC6H6c++Quf6CHO9jVu6ECs3K0UzEUtMhP/5e87wo2k1AH5vNf+d06IHxqJA6odVWGs3IhF7PNUas7KmcGaGEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntdX97rc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735767; x=1759271767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PS9nIrBKXKXl2LyWoaHKQPTE1UYeJftI22u4tb9Q4/Q=;
  b=ntdX97rcTelAdTNLH6uyoDzdFyMeF9G+6tgnNZtss7Nnda+kw9yH97VM
   V9M2DrQyBaSM0LV5rBX2pF76sYKfO0F1MYz41uHBPFtvHxTOaQ2lrJ8hI
   +31AjhwIUWmoVqWp9mhOKXVZfd5yrhBS7JW+stxU18ORoANAjq6YX7XAs
   +daWeB+OFcJZgyxVv6r9yT1Gj1x8X/QoOHQmNauisJE5fuQpA7x8fwNPc
   c+hGO/Z/z4CugtV7p+GTuuh9+cH+jHlS9hOpG5uYtIhiM1GLy/5ePkXHe
   8/UswKt47UpTjX0zCskqeEh6xQmFkVkePnBW+nEDUh4sJtZFN+vtawm7s
   A==;
X-CSE-ConnectionGUID: uikE3ZsISACHZzaudOyZ0A==
X-CSE-MsgGUID: G6iBHLu3QpuprSWos5Gy5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734850"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734850"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:05 -0700
X-CSE-ConnectionGUID: rrrDuzTARPebGhB/MV64Ow==
X-CSE-MsgGUID: 5W3Z5cUPTN6v7aXh9LJuWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496607"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	pmenzel@molgen.mpg.de,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 01/10] ice: set correct dst VSI in only LAN filters
Date: Mon, 30 Sep 2024 15:35:48 -0700
Message-ID: <20240930223601.3137464-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The filters set that will reproduce the problem:
$ tc filter add dev $VF0_PR ingress protocol arp prio 0 flower \
	skip_sw dst_mac ff:ff:ff:ff:ff:ff action mirred egress \
	redirect dev $PF0
$ tc filter add dev $VF0_PR ingress protocol arp prio 0 flower \
	skip_sw dst_mac ff:ff:ff:ff:ff:ff src_mac 52:54:00:00:00:10 \
	action mirred egress mirror dev $VF1_PR

Expected behaviour is to set all broadcast from VF0 to the LAN. If the
src_mac match the value from filters, send packet to LAN and to VF1.

In this case both LAN_EN and LB_EN flags in switch is set in case of
packet matching both filters. As dst VSI for the only LAN enable bit is
PF VSI, the packet is being seen on PF. To fix this change dst VSI to
the source VSI. It will block receiving any packet even when LB_EN is
set by switch, because local loopback is clear on VF VSI during normal
operation.

Side note: if the second filters action is redirect instead of mirror
LAN_EN is clear, because switch is AND-ing LAN_EN from each matched
filters and OR-ing LB_EN.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: 73b483b79029 ("ice: Manage act flags for switchdev offloads")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index e6923f8121a9..ea39b999a0d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -819,6 +819,17 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
 		rule_info.sw_act.src = vsi->idx;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
+		/* This is a specific case. The destination VSI index is
+		 * overwritten by the source VSI index. This type of filter
+		 * should allow the packet to go to the LAN, not to the
+		 * VSI passed here. It should set LAN_EN bit only. However,
+		 * the VSI must be a valid one. Setting source VSI index
+		 * here is safe. Even if the result from switch is set LAN_EN
+		 * and LB_EN (which normally will pass the packet to this VSI)
+		 * packet won't be seen on the VSI, because local loopback is
+		 * turned off.
+		 */
+		rule_info.sw_act.vsi_handle = vsi->idx;
 	} else {
 		/* VF to VF */
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
-- 
2.42.0


