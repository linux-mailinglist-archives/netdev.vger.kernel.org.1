Return-Path: <netdev+bounces-102679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5909043DA
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC6A1F24D5B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6176034;
	Tue, 11 Jun 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOYs5qvM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634F59167
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131370; cv=none; b=kruNvOWzibdmuFEz1gmqGc6hgtkejHuPhN39zURY5Y1Y5Eos301pwqrrq+mkHuXh9ALPDyK1PikqsaElnD1L6rvnDPF34eePtifmKv+IqDS8EKJZ33clJIZ6kDETfA+7DXcGw8L+oJCh63TvQAZgjR9xtGpPeGTiuAKceR24FN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131370; c=relaxed/simple;
	bh=pJgk+4GFxhSP9n+1P6GfF3XIwj+YEmPeHsu9OPdKcTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8ezqup2mqV8fw3j1RlAshfncTxgP7CZUVy7VS+V6hfCOykQOesImfFVnCI5jvCjst9jDVH5c68fL67vbyZFEW3lidj+clSTVCq+G2jePh0LIbXx1ivHwSFfzZJiyWZFkcKlkHqlYsC2JNzMQe0qC3CXUmlSHpMc4D11rgEI2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOYs5qvM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718131369; x=1749667369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pJgk+4GFxhSP9n+1P6GfF3XIwj+YEmPeHsu9OPdKcTo=;
  b=WOYs5qvMVRid4ebAE9IxuyfJvkGRxrtmc2Ax3Gvbq1NiI9CZAV5xJIUx
   swWyvQWlN3g8rg8HtHKGF17CjqIZshBoCesIOe0QHy0AbitGTacL0Pcgv
   /J8L+41KDBE/h2+LmH447grpTcZLizJthEZKuviFdqqN7Ne3P7VKAaNbr
   sz0poI6r9nVu0p5Tb2q6qE+8CaWFEmBd9YpGhBxskCd6lPwy/Mur23GLt
   vBJhSt+mLD966Zp0zvXW++P/nLVjFr2bLqonuhjt4lV6SJhIYpM8HB5mK
   KZlKQXjFiutZgzEYboaVf7tGy18mNh6TVtanQW33RlZhCAPB14gEGMgVY
   A==;
X-CSE-ConnectionGUID: 8PNLrqubSBG2XJ6Uvm4Ckg==
X-CSE-MsgGUID: XRr9BhaCT4mF5aTJC+08yA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12025550"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="12025550"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:42:48 -0700
X-CSE-ConnectionGUID: Ry+A49y0SbiXMF3PTgPQzQ==
X-CSE-MsgGUID: NdkJlj00TDyp3irne0NdrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39592500"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2024 11:42:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/4] ice: fix 200G link speed message log
Date: Tue, 11 Jun 2024 11:42:37 -0700
Message-ID: <20240611184239.1518418-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
References: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Commit 24407a01e57c ("ice: Add 200G speed/phy type use") added support
for 200G PHY speeds, but did not include 200G link speed message
support. As a result the driver incorrectly reports Unknown for 200G
link speed.

Fix this by adding 200G support to ice_print_link_msg().

Fixes: 24407a01e57c ("ice: Add 200G speed/phy type use")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 45d850514f4c..1766230abfff 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -805,6 +805,9 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	}
 
 	switch (vsi->port_info->phy.link_info.link_speed) {
+	case ICE_AQ_LINK_SPEED_200GB:
+		speed = "200 G";
+		break;
 	case ICE_AQ_LINK_SPEED_100GB:
 		speed = "100 G";
 		break;
-- 
2.41.0


