Return-Path: <netdev+bounces-156006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95651A049CB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FEA3A58DE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582581F427D;
	Tue,  7 Jan 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2A9Rb4V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91B2594BF
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276523; cv=none; b=mA4Fd6lyHwelE+E6OdN2f8TxyTeb7uW+P9R8cNQLakjs3RzuA5RHq1NMgeV6AOwyBbgjEkwqTdMKcL+j4+CXpOKGgLZgadVYDqg9Dm5gj6lpyXFGRZXclZ83BT5s9yHBNcZ/gzjTpa6cJk610QxPDN7IuDxs//e283x26jgDXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276523; c=relaxed/simple;
	bh=K1VhwAwftNI/LMk7B6u+/AqNLO8CHp59+gPqHQDqFCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJMwaGTpeQQ9iwToJOql9XeA3pIxF1CHBunbNFqtwjSzhie0TYE/kcr6UzYuJgVMyf9WUUq2RZTAlw0XgYx9WZ4JzIXO63zDSfGTr7h0n9FDnTKc4K/vEVdDfz3Laph1Ft9+UmbAWb9YsJbas1VMJKRpVu9r50PFzVAeafjcOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2A9Rb4V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736276522; x=1767812522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1VhwAwftNI/LMk7B6u+/AqNLO8CHp59+gPqHQDqFCg=;
  b=O2A9Rb4VVSnFI9QZZiSfEgc4eA9yew6rP+nTpDJteBy8deDIOgzg81CV
   s1PdnK7qfs3RcbKqMlojMLNmRgZ8DaBtkpkrhl7fve56MvFoqN7iE90CU
   lX5jc6rtGSCCey4Ddg2uCiW+DpfcU+ctj+eUr5pzAegUy/HIQFtwwEXbZ
   NLrP+tcyX5ITMm05IdYuKNdkCRsvQR3NL7Rj+wm4i0GegXIVBd36tsyRL
   1tthU4OuW06DBvUo4jxLXmv68Nuiej90YukOCQcGsPm6HH8HICGXbYxDy
   O5qXiT5zbt+udDa0O+lxoWiriB279fTUUXC30n+tCT/46srm/t3QGqdbQ
   Q==;
X-CSE-ConnectionGUID: 9okCwXKEQv2oSk6DcKhZcA==
X-CSE-MsgGUID: EUf8+//4Suq8LDG9Ja96Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="24083641"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="24083641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 11:02:00 -0800
X-CSE-ConnectionGUID: OKcQWArkT2CzDu4CKUrafA==
X-CSE-MsgGUID: Ch/ZWNmKQbOVzYoZXBNAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="133709291"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 07 Jan 2025 11:02:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	pmenzel@molgen.mpg.de,
	olteanv@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/3] ice: fix incorrect PHY settings for 100 GB/s
Date: Tue,  7 Jan 2025 11:01:46 -0800
Message-ID: <20250107190150.1758577-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
References: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

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
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 585ce200c60f..d75f0eddd631 100644
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
-- 
2.47.1


