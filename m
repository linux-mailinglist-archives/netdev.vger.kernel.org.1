Return-Path: <netdev+bounces-168588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD3A3F693
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A49F865ADC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F320B80A;
	Fri, 21 Feb 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6OpIG0y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D3209F51
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146012; cv=none; b=ebKedAtj6OGw8JiOglk2PDPlkidFVXlIAnWw8y0QSgpjHxgpMiV+Xahioe1FnjmR/Mq7ijLgz67zsVSyq7hWEhTpAXePQmbShi+X9MInJwOEnWNBa8Mf/3WsJIQUWgWFzyvciNW3TgWwp3MQ/O4r2ayE6J2L3supEr2qTOGi1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146012; c=relaxed/simple;
	bh=QoZFiFZcge5y8/gZT2+9YlDQ0HWRHX2zKe13LthsFRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfUZ52gSAcZgMqjUKA09c6cgH8hbmro5qHigGlwLGK14YUqpiI3XKXR7pW1+U7mAudzIhzkCjUNLj+lggsSBKRp+zf+SeWvO7HHp7AkpbjACiv2Cw3/C7I0yIu9RoeBoIRgpZW8UrZCDpt+olIAHclyeAIp1rj9khHepRDP7t/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6OpIG0y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740146010; x=1771682010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QoZFiFZcge5y8/gZT2+9YlDQ0HWRHX2zKe13LthsFRk=;
  b=I6OpIG0yNkGlEhTg/Kx18/9/vdV10jrbZ8h+Qkt4MTHPsCA+YVcchcEw
   McB1xPnaJCfB8llNKerwHH9atuU0BMrrrNsyuEBoowc41OxLk9Lp3etpd
   G1WPJNS57pe+uUvr1zu0vWvTPz4EH6E5wsFJvTz7welNxleADCT+GoVOn
   KVKPUSs8r3QC1h7rabRBbIyYaszpsmwFXSErBAUIZ6R447tsVGM4VAFlY
   NTWgjpNGuCpV/LgeG9eoHgfZNxRzOckwtQmyT7/IYBZZWHw6Ko7xi5qzO
   UKTaWBn+siX0pmTHEJXOBTu8j7zndNHA52vqNqjlYuMBaPuV9DlZ/eZWb
   Q==;
X-CSE-ConnectionGUID: SbDsr+xsQAi/DG4OyHtvkQ==
X-CSE-MsgGUID: 5UeDn9w5ROCR6vjMhkejTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66329000"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="66329000"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:53:20 -0800
X-CSE-ConnectionGUID: Np+g1ynGReOYo1NG/v908g==
X-CSE-MsgGUID: MT3b49uxQHONawmjxFBjgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="115905473"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.0.65])
  by fmviesa010.fm.intel.com with ESMTP; 21 Feb 2025 05:53:19 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	andrew@lunn.ch,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2] ixgbe: fix media type detection for E610 device
Date: Fri, 21 Feb 2025 14:53:15 +0100
Message-ID: <20250221135315.5105-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
device") introduced incorrect media type detection for E610 device. It
reproduces when advertised speed is modified after driver reload. Clear
the previous outdated PHY type high value.

Reproduction steps:
modprobe ixgbe
ethtool -s eth0 advertise 0x1000000000000
rmmod ixgbe
modprobe ixgbe
ethtool -s eth0 advertise 0x1000000000000

Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
v1 -> v2
  More commit message details and reproduction steps added
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668..0dfefd2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1453,9 +1453,11 @@ enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw)
 			hw->link.link_info.phy_type_low = 0;
 		} else {
 			highest_bit = fls64(le64_to_cpu(pcaps.phy_type_low));
-			if (highest_bit)
+			if (highest_bit) {
 				hw->link.link_info.phy_type_low =
 					BIT_ULL(highest_bit - 1);
+				hw->link.link_info.phy_type_high = 0;
+			}
 		}
 	}
 
-- 
2.43.0


