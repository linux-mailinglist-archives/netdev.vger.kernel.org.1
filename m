Return-Path: <netdev+bounces-228206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CDBC4AA7
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B853A86C8
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E242246BA9;
	Wed,  8 Oct 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mez3PiSk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DDE2F3C38
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924812; cv=none; b=T7uvoUKT1FX+XWSOo2FMtMIsj3qJm6IcMo+e3QHkRz0898burI3qyMATo1FpGXw4kBjNIUqM2UVTVMOB3Z+r8j/LiQ33yxxK+GDHyJCxd/rZbIHYIET0EsCJMhv7sAnO+DRb440wsQWUNvGq5QhJe42AzQ6GVGZIgm4ZYvhTgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924812; c=relaxed/simple;
	bh=XGOe8jWd4nVrbi8ZdLlMxwTp5ZPj5CcYqRnLiotT1vI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZNMHZfRqWaPvse8ZyaorKF65h2EnRjntGa/ruNjPsI2u+1oH9Y0rKR7O8OVucZadX5HVJTBuxXezZmi3gquDFL2Gz+T5UZp+fjhtHmvBPxg/qS67TZWtLvgNtmdkbOZNjPF3TBKX4h28YpNgFZwjFS+qF4I150Y1jCXl9nG28Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mez3PiSk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759924810; x=1791460810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XGOe8jWd4nVrbi8ZdLlMxwTp5ZPj5CcYqRnLiotT1vI=;
  b=Mez3PiSkWjl4p27TKlTHKa886Xkp6yN52pv/Jm4TLXiXtjGNkweKASFp
   oFSywbfRnDUBaSqhOSays5jUoxotNEy+OK4MmlUuQNFsXgKyheH0NKpw1
   9/UsaB7jHbMB7H3NDzXhPj8IapmLTlocamWq6mRc8319+9XgkJJxHCZcD
   OOd6OLik40ZZwIS9uCCJPUvgxzz7CwqD+nu/4xaSK4QmQpOoqwviS2p30
   BG0D/V57TAq5Lx2dT/rkbZMCE1J6cMS3BFAvxDgbbVEeYMPlEaHOyrsfy
   VrIGlKwfoE4TXkBXyIc00h39FbVrjBZXmNOcEAygxbA1acjQf80LVHcid
   A==;
X-CSE-ConnectionGUID: 6oQehOrIScWqtnOp7SMkUQ==
X-CSE-MsgGUID: TRPrMd/7SCieTNsGKRr0sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73541158"
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="73541158"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 05:00:06 -0700
X-CSE-ConnectionGUID: qlmCwMTjQZKyzrMO7KmdDQ==
X-CSE-MsgGUID: BZJmvj+ZRPKr6FtJHShHNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="180090586"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa007.fm.intel.com with ESMTP; 08 Oct 2025 05:00:04 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: fix PTP cleanup on driver removal in error path
Date: Wed,  8 Oct 2025 13:58:11 +0200
Message-Id: <20251008115811.1578695-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve PTP feature cleanup in error path by adding explicit call to
ice_ptp_cleanup_pf in the case in which PTP feature is not fully
operational at the time of driver removal (which is indicated by
ptp->state flag).
At the driver probe, if PTP feature is supported, each PF adds its own
port to the list of ports controlled by ice_adapter object.
Analogously, at the driver remove, it's expected each PF is
responsible for removing previously added port from the list.
If for some reason (like errors in reset handling, NVM update etc.), PTP
feature has not rebuilt successfully, the driver is still responsible for
proper clearing ice_adapter port list. It's done by calling
ice_ptp_cleanup_pf function.
Otherwise, the following call trace is observed when ice_adapter object
is freed (port list is not empty, as it is expected at this stage):

[  T93022] ------------[ cut here ]------------
[  T93022] WARNING: CPU: 10 PID: 93022 at
ice/ice_adapter.c:67 ice_adapter_put+0xef/0x100 [ice]
...
[  T93022] RIP: 0010:ice_adapter_put+0xef/0x100 [ice]
...
[  T93022] Call Trace:
[  T93022]  <TASK>
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  ? __warn.cold+0xb0/0x10e
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  ? report_bug+0xd8/0x150
[  T93022]  ? handle_bug+0xe9/0x110
[  T93022]  ? exc_invalid_op+0x17/0x70
[  T93022]  ? asm_exc_invalid_op+0x1a/0x20
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  pci_device_remove+0x42/0xb0
[  T93022]  device_release_driver_internal+0x19f/0x200
[  T93022]  driver_detach+0x48/0x90
[  T93022]  bus_remove_driver+0x70/0xf0
[  T93022]  pci_unregister_driver+0x42/0xb0
[  T93022]  ice_module_exit+0x10/0xdb0 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
...
[  T93022] ---[ end trace 0000000000000000 ]---
[  T93022] ice: module unloaded

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fb0f6365a6d6..c43a7973d70f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3282,8 +3282,10 @@ void ice_ptp_init(struct ice_pf *pf)
  */
 void ice_ptp_release(struct ice_pf *pf)
 {
-	if (pf->ptp.state != ICE_PTP_READY)
+	if (pf->ptp.state != ICE_PTP_READY) {
+		ice_ptp_cleanup_pf(pf);
 		return;
+	}
 
 	pf->ptp.state = ICE_PTP_UNINIT;
 

base-commit: 8b223715f39c8a944abff2831c47d5509fdb6e57
-- 
2.39.3


