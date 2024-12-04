Return-Path: <netdev+bounces-148978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0079E3B99
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA33B23E94
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B51AF0CD;
	Wed,  4 Dec 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlIe41K3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB59189F57
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318555; cv=none; b=ggdOQpNVi45q2+c8UhEXaBKngTCe/2Tu63fMeQKTfmAz5Up7rIDQlJN4GSFl1fldbPjnWkZaeya+YwYO1kHaqZwJyby+F1kD/rAXwvPPvWE+PcbH/1puphI8F8pcKgnWhpaaswSuD/4RrynpY5BlBJPz3UH0KabSUN/YTWGvRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318555; c=relaxed/simple;
	bh=xjbVOAw11UkVjMBe9c9V269dVjQ70I1jCvLYv7Db78c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNNiC8Ltkz9AK3JBpa766NSCimpdiHcaYVXDmG8xn7BB/2RsF5HLKK//YRWeTNF/ZLbi9VpsMnkTTj//hCn5DWGsFDI7sZzAGZ2DreAaLKjWTReAuyhVHOAARXvvIqKtwCYoXjSfn4twHaDlVzSp1eUxNCxYAupWdDVQf8Wvi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlIe41K3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733318554; x=1764854554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xjbVOAw11UkVjMBe9c9V269dVjQ70I1jCvLYv7Db78c=;
  b=XlIe41K36XqwD3FMumE/6D5n7w9RskOtNy8YOymRspj9yfQx0uIZiKJX
   1z4lNTVUHCrjj4OJPvZ4pBVLl1E5rCw4+mdeAN+1M7YdcIdgP782P1HSq
   i1FR8l2wBKDDcRcQ3bLNDNybKZyVlhau7UtI2KSnQttIwcP6A1jf04Yj1
   z2Hd0eHGvUG92m5UfAhSX96mJxcVsAKcsXosAtwHqbk2KVZ9+zF3mT/J4
   au1NAymg2IL1k+ASXWKUvlXv8roG5LdWDBx9fjellokDZmRivGWsOq7fd
   QNtFR1hSJlSOU4U+FQR/iujQghNLHPPqJ3DNi0NE2i5EhUXmYqTrUMjll
   g==;
X-CSE-ConnectionGUID: 7fcJra4sQDGPxtNWKhJkhQ==
X-CSE-MsgGUID: 2CXVlFkwSKSdBDCGFce4+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44193996"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44193996"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 05:22:33 -0800
X-CSE-ConnectionGUID: Jzkjqa9qQRyWhIwNsfSBgA==
X-CSE-MsgGUID: NhqA2S8TR6e75c5kZdSRAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98785944"
Received: from pae-dbg-r750-02-263.igk.intel.com ([172.28.191.215])
  by orviesa003.jf.intel.com with ESMTP; 04 Dec 2024 05:22:30 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	milena.olech@intel.com,
	pmenzel@molgen.mpg.de,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net v2] ice: fix incorrect PHY settings for 100 GB/s
Date: Wed,  4 Dec 2024 14:22:18 +0100
Message-Id: <20241204132218.1060616-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp4l application reports too high offset when ran on E823 device
with a 100GB/s link. Those values cannot go under 100ns, like in a
working case when using 100 GB/s cable.

This is due to incorrect frequency settings on the PHY clocks for
100 GB/s speed. Changes are introduced to align with the internal
hardware documentation, and correctly initialize frequency in PHY
clocks with the frequency values that are in our HW spec.

To reproduce the issue run ptp4l as a Time Receiver on E823 device,
and observe the offset, which will never approach values seen
in the PTP working case.

Reproduction output:
ptp4l -i enp137s0f3 -m -2 -s -f /etc/ptp4l_8275.conf
ptp4l[5278.775]: master offset      12470 s2 freq  +41288 path delay -3002
ptp4l[5278.837]: master offset      10525 s2 freq  +39202 path delay -3002
ptp4l[5278.900]: master offset     -24840 s2 freq  -20130 path delay -3002
ptp4l[5278.963]: master offset      10597 s2 freq  +37908 path delay -3002
ptp4l[5279.025]: master offset       8883 s2 freq  +36031 path delay -3002
ptp4l[5279.088]: master offset       7267 s2 freq  +34151 path delay -3002
ptp4l[5279.150]: master offset       5771 s2 freq  +32316 path delay -3002
ptp4l[5279.213]: master offset       4388 s2 freq  +30526 path delay -3002
ptp4l[5279.275]: master offset     -30434 s2 freq  -28485 path delay -3002
ptp4l[5279.338]: master offset     -28041 s2 freq  -27412 path delay -3002
ptp4l[5279.400]: master offset       7870 s2 freq  +31118 path delay -3002

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
Changelog:
v2:
change commit message
v1:
https://lore.kernel.org/intel-wired-lan/20241126102311.344972-1-przemyslaw.korba@intel.com/
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 6620642077bb..bdb1020147d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -761,9 +761,9 @@ const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD] = {
 		/* rx_desk_rsgb_par */
 		644531250, /* 644.53125 MHz Reed Solomon gearbox */
 		/* tx_desk_rsgb_pcs */
-		644531250, /* 644.53125 MHz Reed Solomon gearbox */
+		390625000, /* 390.625 MHz Reed Solomon gearbox */
 		/* rx_desk_rsgb_pcs */
-		644531250, /* 644.53125 MHz Reed Solomon gearbox */
+		390625000, /* 390.625 MHz Reed Solomon gearbox */
 		/* tx_fixed_delay */
 		1620,
 		/* pmd_adj_divisor */

base-commit: 6ef5f61a4aa7d4df94a855a44f996bff08b0be83
-- 
2.31.1


