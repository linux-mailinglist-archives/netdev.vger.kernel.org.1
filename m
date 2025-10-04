Return-Path: <netdev+bounces-227843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86520BB87A1
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 03:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312194C3E12
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956B81DC9B1;
	Sat,  4 Oct 2025 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEu+/A1T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5E19ABDE;
	Sat,  4 Oct 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540311; cv=none; b=qAUC6XeL07v9mTJ5fcnvL7qwe3mP04RQxw1bUtcN9Z2JQDrwXyL+saponYtHX03UWwsnwgPi4ocib6uJXJUv+bLpkvxELy4jsFiIW9uR+Vur+Cw6sQz/c/7iZZddupMe9aHZz8ewR/O/fq5E+zMkHEllo/Ic9y1F4AN8Jk642NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540311; c=relaxed/simple;
	bh=rZZepSYfDiUzsD7VqNluWBfF+i3UxghvOp7/jfoABGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbFZLpyJNOoszG3n1aAaPtIwPwagshkk7GCfueHk3oJM2uMaiSpYFqC8I3iPpPWM/8KDrNiQ6TpUSgGkBo6KPZxQ5APNjErIjgIdthg3jQ3jqks+nc0QX48KT/lsy698Pjo9QuejccDpZfOelVvhRWN/qjCVeCPAprkMTEHeAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEu+/A1T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759540309; x=1791076309;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rZZepSYfDiUzsD7VqNluWBfF+i3UxghvOp7/jfoABGM=;
  b=HEu+/A1TAsNRIhwMZkAzJYQlGYqLxxF7C+f6npOV4Bjv4KTEBDdMBq13
   8DRIO+KiDUxlB3n10hIlR6s3Sp2zS+jKdWgmG2SKIrP2s2CPves3pRHeq
   L4d1knM5dYW39qXyrDUx1joo+weURJ+KrUfw/nKfptcokapfmbQ0JHCw/
   evJYDX5uNPJ9gLmwCPx5DYKRh2CjsnzDZ6wDPoNPyJJZ3C8INfhqtGMLQ
   xAPdSlNai0ettIS6hMpSU3cLrN5pfQJDN29rHoapOmSKuQZ1ejV0WeTb+
   nnskKlNZIVI2yZ0ajO3KJRuE+y5hnWeAlmGnjP+4zywFaaJLfBGeph2ed
   A==;
X-CSE-ConnectionGUID: T1hSJBKDRCqd1aRi346NaA==
X-CSE-MsgGUID: dQQ9PIDIRKCwd9yIkSHtwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65650047"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65650047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
X-CSE-ConnectionGUID: iycJbPhkQiGswpMTEukUiw==
X-CSE-MsgGUID: LWNwNC2MSMGW1d7Zd8uotQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="178543217"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 03 Oct 2025 18:09:49 -0700
Subject: [PATCH net v2 6/6] ixgbe: fix too early devlink_free() in
 ixgbe_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-jk-iwl-net-2025-10-01-v2-6-e59b4141c1b5@intel.com>
References: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
In-Reply-To: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=uPUFa5XRwwizNw3cq6xE4VL/A1dp66wRXQlgd3W4V14=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowHJX4v3KJ4HugVTAnnnh4+rbD6dsVmY9Ny3lPLTkkpO
 c+W2JfSUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwETUixn+hzzk251/Ide93aq6
 pPNTu+FKa669fU025pu01pRw7nbnZ2R48IvNbI+p2NSf8X7z54sKOXZxGe0RTvL0q+Mp38sueI8
 VAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Koichiro Den <den@valinux.co.jp>

Since ixgbe_adapter is embedded in devlink, calling devlink_free()
prematurely in the ixgbe_remove() path can lead to UAF. Move devlink_free()
to the end.

KASAN report:

 BUG: KASAN: use-after-free in ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
 Read of size 8 at addr ffff0000adf813e0 by task bash/2095
 CPU: 1 UID: 0 PID: 2095 Comm: bash Tainted: G S  6.17.0-rc2-tnguy.net-queue+ #1 PREEMPT(full)
 [...]
 Call trace:
  show_stack+0x30/0x90 (C)
  dump_stack_lvl+0x9c/0xd0
  print_address_description.constprop.0+0x90/0x310
  print_report+0x104/0x1f0
  kasan_report+0x88/0x180
  __asan_report_load8_noabort+0x20/0x30
  ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
  ixgbe_clear_interrupt_scheme+0xf8/0x130 [ixgbe]
  ixgbe_remove+0x2d0/0x8c0 [ixgbe]
  pci_device_remove+0xa0/0x220
  device_remove+0xb8/0x170
  device_release_driver_internal+0x318/0x490
  device_driver_detach+0x40/0x68
  unbind_store+0xec/0x118
  drv_attr_store+0x64/0xb8
  sysfs_kf_write+0xcc/0x138
  kernfs_fop_write_iter+0x294/0x440
  new_sync_write+0x1fc/0x588
  vfs_write+0x480/0x6a0
  ksys_write+0xf0/0x1e0
  __arm64_sys_write+0x70/0xc0
  invoke_syscall.constprop.0+0xcc/0x280
  el0_svc_common.constprop.0+0xa8/0x248
  do_el0_svc+0x44/0x68
  el0_svc+0x54/0x160
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x1b0/0x1b8

Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6218bdb7f941..86b9caece104 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -12091,7 +12091,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
 
 	devl_port_unregister(&adapter->devlink_port);
 	devl_unlock(adapter->devlink);
-	devlink_free(adapter->devlink);
 
 	ixgbe_stop_ipsec_offload(adapter);
 	ixgbe_clear_interrupt_scheme(adapter);
@@ -12127,6 +12126,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 
 	if (disable_dev)
 		pci_disable_device(pdev);
+
+	devlink_free(adapter->devlink);
 }
 
 /**

-- 
2.51.0.rc1.197.g6d975e95c9d7


