Return-Path: <netdev+bounces-172702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E3A55C1B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213C03A6C0C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D4748D;
	Fri,  7 Mar 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdmCqcXf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EA4A21
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308149; cv=none; b=fwfhaljM9ob+GInH+FSkOS9QRN/Egsw+qc2p7vxZcn2cii/6o7LqpXb4HaLgICr3icwuqZrNdFQUYoLRoVfsxzvcE4cnNIcgHV3LSJ6gyNQ+RKf1mXM1qzEjdPcdKJOUmmD1yPmz9OfQvJiPiMo/Fch9h2lfjR8pa5GPZgssaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308149; c=relaxed/simple;
	bh=caDuKs0AuG92X3nJAsyNu2lZqkO2rfULuHB5rDkSwD4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tc0VmpdLyVAY7EcSPzAIQ410+p8gVc0zP2ujflU68MnmEGawnQFuHa9i50GgUEhlLW5OlhSOKCoWUubcjWUAYhcg/MoE0masPgAzHPeEO6qCRzoMu0lk0IvJUy0hSa9k9CfoLr6W/IZ/3sm06n1elSFLAFvrlNFdwyZPl5e1+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdmCqcXf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741308148; x=1772844148;
  h=from:to:cc:subject:date:message-id;
  bh=caDuKs0AuG92X3nJAsyNu2lZqkO2rfULuHB5rDkSwD4=;
  b=GdmCqcXfIDQO/H9QtvkSEQ+N7V16mMYe5JI6JSwwiEgGTL3uI2OEth63
   mVEktLAc1lnn+ZJ8Xt36r7N/uh7lQbAss/bipTM2ScZ/vDD3ksa5Xzy2F
   oU1zRq4yBFWVBk61fDF71YPj1YVYueAlBhTK5hb/pLVrZPKFerqJ5O90Q
   vKG0RuCSbnuCynCrQINoESb2eV/RmVxV+ugMxsPTAB3ac4GDK8o0MBRfw
   Nl/A1L6EMncBryRyILb5nZ6N8LF2vjHWXy46KXWDm6xpAhBzDB5MC6/xz
   5jA/3n2rK+Hw2wxC2dXGMO4JQn4SYmVW7853u/UhG8UL1TQy9OyAAZpM3
   g==;
X-CSE-ConnectionGUID: FX8LIWCKSIqCPsga9sJfHA==
X-CSE-MsgGUID: aezeNPg1RxCca0vV+qoFXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53738396"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="53738396"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 16:42:27 -0800
X-CSE-ConnectionGUID: 6SfQAwSfQseC6Y457pir9w==
X-CSE-MsgGUID: Ox9RJNcLQHOnu5XjBxUFTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119094386"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2025 16:42:27 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	decot@google.com,
	willemb@google.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	madhu.chittim@intel.com,
	Aleksandr.Loktionov@intel.com,
	yuma@redhat.com,
	mschmidt@redhat.com
Subject: [PATCH iwl-net] idpf: fix adapter NULL pointer dereference on reboot
Date: Thu,  6 Mar 2025 16:39:56 -0800
Message-Id: <20250307003956.22018-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Driver calls idpf_remove() from idpf_shutdown(), which can end up
calling idpf_remove() again when disabling SRIOV.

echo 1 > /sys/class/net/<netif>/device/sriov_numvfs
reboot

BUG: kernel NULL pointer dereference, address: 0000000000000020
...
RIP: 0010:idpf_remove+0x22/0x1f0 [idpf]
...
? idpf_remove+0x22/0x1f0 [idpf]
? idpf_remove+0x1e4/0x1f0 [idpf]
pci_device_remove+0x3f/0xb0
device_release_driver_internal+0x19f/0x200
pci_stop_bus_device+0x6d/0x90
pci_stop_and_remove_bus_device+0x12/0x20
pci_iov_remove_virtfn+0xbe/0x120
sriov_disable+0x34/0xe0
idpf_sriov_configure+0x58/0x140 [idpf]
idpf_remove+0x1b9/0x1f0 [idpf]
idpf_shutdown+0x12/0x30 [idpf]
pci_device_shutdown+0x35/0x60
device_shutdown+0x156/0x200
...

Replace the direct idpf_remove() call in idpf_shutdown() with
idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(), which perform
the bulk of the cleanup, such as stopping the init task, freeing IRQs,
destroying the vports and freeing the mailbox.

Reported-by: Yuying Ma <yuma@redhat.com>
Fixes: e850efed5e15 ("idpf: add module register and probe functionality")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index b6c515d14cbf..bec4a02c5373 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -87,7 +87,11 @@ static void idpf_remove(struct pci_dev *pdev)
  */
 static void idpf_shutdown(struct pci_dev *pdev)
 {
-	idpf_remove(pdev);
+	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&adapter->vc_event_task);
+	idpf_vc_core_deinit(adapter);
+	idpf_deinit_dflt_mbx(adapter);
 
 	if (system_state == SYSTEM_POWER_OFF)
 		pci_set_power_state(pdev, PCI_D3hot);
-- 
2.17.2


