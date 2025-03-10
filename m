Return-Path: <netdev+bounces-173611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AFEA5A007
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC57F1890C0B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08828235374;
	Mon, 10 Mar 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+S5s0aJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65F233D9D
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628712; cv=none; b=S9MmLxk5wAIj0b0MzibRsY9e+th27mtzLGSp0qbJYvW7E/HTK+DEpf0bkKhYu2kRMI6MdEbmnfsCMx4D5sq+76wsvQzX+QwZVeW5ITeHdx4aiC7ecInBtkQCD0rXuLDez5rqbHoGQD/ID4xjC0AnaKKpUAuI5cfJQpT5psMmE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628712; c=relaxed/simple;
	bh=wfZfWdFe8R/2a4rvfWKXB71yglMS89Qef/gmNTvGj+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGe7p90XKtaEupowGo4/ujsROevGztclIYuHvetbPATj3b9FgZalM2gdsZbUyc9fM1jdsY5+FemcF3LL/DHlVTdexIthHc0BbFtPGjlntRrWPtfH4g/H0IQL7TVpaXRb0Y4g02+TOF+wgew0NafggfdWQNEMhnf4fe59XpNp+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+S5s0aJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741628711; x=1773164711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wfZfWdFe8R/2a4rvfWKXB71yglMS89Qef/gmNTvGj+o=;
  b=A+S5s0aJUSs4ugkeWXgag8H1bGm4fVXzm2Wo+8vAL7jh3ck8COxT/i/m
   fV4SAkpYSsOOrK4Oc2ANfogfUgSCfpYFwKV7okGINqU64BXhrShNEKTpr
   6ZbjhhYdDkSJi8heiFUIc4l0MlPPqYC+Jog+S1sXgJbyi4/gRF49QuE44
   w1QeYLH8JheIB5gxL43TXBvj5keA/NHVxg3jZ2rTKeX+HX9NtQnW18YEU
   K45kf9T/dkUDgBX4mN5pDHeWNB5E9ee5CTHB6iFi8/hfqwKMAZrNgv9iQ
   /MenBchv5X2yNPPlK0XwA3qSlwW+YmV7r/45JiD3ZeSoz1e8Qz7f/AoAv
   Q==;
X-CSE-ConnectionGUID: 06MOvH3TStyTQ54F7BwPSQ==
X-CSE-MsgGUID: ZYdqRRimTfG+Ib35Veu9VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46549024"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46549024"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:45:08 -0700
X-CSE-ConnectionGUID: kLphP5JqR9C4sQJA+7ZaYw==
X-CSE-MsgGUID: 1HLY68ASRLCGSv2XRBxPYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120950835"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2025 10:45:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jeremiah Lokan <jeremiahx.j.lokan@intel.com>
Subject: [PATCH net-next 6/6] ixgbe: add support for thermal sensor event reception
Date: Mon, 10 Mar 2025 10:44:59 -0700
Message-ID: <20250310174502.3708121-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
References: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

E610 NICs unlike the previous devices utilising ixgbe driver
are notified in the case of overheating by the FW ACI event.

In event of overheat when threshold is exceeded, FW suspends all
traffic and sends overtemp event to the driver. Then driver
logs appropriate message and disables the adapter instance.
The card remains in that state until the platform is rebooted.

This approach is a solution to the fact current version of the
E610 FW doesn't support reading thermal sensor data by the
SW. So give to user at least any info that overtemp event
has occurred, without interface disappearing from the OS
without any note.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Jeremiah Lokan <jeremiahx.j.lokan@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 467f81239e12..481f917f7ed2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3185,6 +3185,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 		case ixgbe_aci_opc_get_link_status:
 			ixgbe_handle_link_status_event(adapter, &event);
 			break;
+		case ixgbe_aci_opc_temp_tca_event:
+			e_crit(drv, "%s\n", ixgbe_overheat_msg);
+			ixgbe_down(adapter);
+			break;
 		default:
 			e_warn(hw, "unknown FW async event captured\n");
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 8d06ade3c7cd..617e07878e4f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -171,6 +171,9 @@ enum ixgbe_aci_opc {
 	ixgbe_aci_opc_done_alt_write			= 0x0904,
 	ixgbe_aci_opc_clear_port_alt_write		= 0x0906,
 
+	/* TCA Events */
+	ixgbe_aci_opc_temp_tca_event                    = 0x0C94,
+
 	/* debug commands */
 	ixgbe_aci_opc_debug_dump_internals		= 0xFF08,
 
-- 
2.47.1


