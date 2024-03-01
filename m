Return-Path: <netdev+bounces-76545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3071386E258
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D595D28211D
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D16EB5C;
	Fri,  1 Mar 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG+8a3yy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7904176D
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300254; cv=none; b=AFFIQ4g+EIDRIjf4jDxQ3iukH2AQqqEDB/gjHMDGoN8Ox5skPwrzVNz9UhspA/H+2NjSMf8Cs0tTApZAkc2exeJD44IrCesZnTAis+IeE/VuLyESEM1DnAEhqKZ8AtI/jAuPq8YusJpDxkYw+InsV7rnPQ0fc37VdcAB5yVdgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300254; c=relaxed/simple;
	bh=1V8nDM53JXoM0cJ36ZRF4x0U85iVibFgiEfuseE5+sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxKLPNzrxF6SHytz3GiU2OMqghpjK363rC4MnyKtCGBY3B75gIFPaVpVS1ThOwrwlIOx50KD/w3F74/siejU+u1v5twM3kI2VqbKOTFvlzh3mhabwnW/Y2pRNz3W7Tu71EQHe8fW1gmUF/L3M57joiX76nuFw+plNZj2yeP7/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BG+8a3yy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709300251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+PD+K2dix4swtYoimOlyyuOQby5BMQ4/clZPCzByXE=;
	b=BG+8a3yyrAYswAfj8kp81T1iu1h/HTw2U/U/QSysTImmKS7AD9KSTyzJlo3HWg3z2byW9h
	yIexJ3YE1gp2EYnCV3oKBnNV7aD6h7i0S4A+gRoXzZotRG/W7gJU7y+NOARxU/EmjAv4S3
	ihIZj3CSR1bqWXsr/WhTfdYSDUelV1k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-Ydw7EB_QPwqMSvykVrHVTg-1; Fri,
 01 Mar 2024 08:37:23 -0500
X-MC-Unique: Ydw7EB_QPwqMSvykVrHVTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E11E3C0ED70;
	Fri,  1 Mar 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 531E61BDB1;
	Fri,  1 Mar 2024 13:37:21 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net] ice: fix uninitialized dplls mutex usage
Date: Fri,  1 Mar 2024 14:37:08 +0100
Message-ID: <20240301133708.214622-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The pf->dplls.lock mutex is initialized too late, after its first use.
Move it to the top of ice_dpll_init.
Note that the "err_exit" error path destroys the mutex. And the mutex is
the last thing destroyed in ice_dpll_deinit.
This fixes the following warning with CONFIG_DEBUG_MUTEXES:

 ice 0000:10:00.0: The DDP package was successfully loaded: ICE OS Default Package version 1.3.36.0
 ice 0000:10:00.0: 252.048 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x16 link)
 ice 0000:10:00.0: PTP init successful
 ------------[ cut here ]------------
 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 0 PID: 410 at kernel/locking/mutex.c:587 __mutex_lock+0x773/0xd40
 Modules linked in: crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ice(+) nvme nvme_c>
 CPU: 0 PID: 410 Comm: kworker/0:4 Not tainted 6.8.0-rc5+ #3
 Hardware name: HPE ProLiant DL110 Gen10 Plus/ProLiant DL110 Gen10 Plus, BIOS U56 10/19/2023
 Workqueue: events work_for_cpu_fn
 RIP: 0010:__mutex_lock+0x773/0xd40
 Code: c0 0f 84 1d f9 ff ff 44 8b 35 0d 9c 69 01 45 85 f6 0f 85 0d f9 ff ff 48 c7 c6 12 a2 a9 85 48 c7 c7 12 f1 a>
 RSP: 0018:ff7eb1a3417a7ae0 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
 RDX: 0000000000000002 RSI: ffffffff85ac2bff RDI: 00000000ffffffff
 RBP: ff7eb1a3417a7b80 R08: 0000000000000000 R09: 00000000ffffbfff
 R10: ff7eb1a3417a7978 R11: ff32b80f7fd2e568 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ff32b7f02c50e0d8
 FS:  0000000000000000(0000) GS:ff32b80efe800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055b5852cc000 CR3: 000000003c43a004 CR4: 0000000000771ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __warn+0x84/0x170
  ? __mutex_lock+0x773/0xd40
  ? report_bug+0x1c7/0x1d0
  ? prb_read_valid+0x1b/0x30
  ? handle_bug+0x42/0x70
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __mutex_lock+0x773/0xd40
  ? rcu_is_watching+0x11/0x50
  ? __kmalloc_node_track_caller+0x346/0x490
  ? ice_dpll_lock_status_get+0x28/0x50 [ice]
  ? __pfx_ice_dpll_lock_status_get+0x10/0x10 [ice]
  ? ice_dpll_lock_status_get+0x28/0x50 [ice]
  ice_dpll_lock_status_get+0x28/0x50 [ice]
  dpll_device_get_one+0x14f/0x2e0
  dpll_device_event_send+0x7d/0x150
  dpll_device_register+0x124/0x180
  ice_dpll_init_dpll+0x7b/0xd0 [ice]
  ice_dpll_init+0x224/0xa40 [ice]
  ? _dev_info+0x70/0x90
  ice_load+0x468/0x690 [ice]
  ice_probe+0x75b/0xa10 [ice]
  ? _raw_spin_unlock_irqrestore+0x4f/0x80
  ? process_one_work+0x1a3/0x500
  local_pci_probe+0x47/0xa0
  work_for_cpu_fn+0x17/0x30
  process_one_work+0x20d/0x500
  worker_thread+0x1df/0x3e0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x103/0x140
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x31/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>
 irq event stamp: 125197
 hardirqs last  enabled at (125197): [<ffffffff8416409d>] finish_task_switch.isra.0+0x12d/0x3d0
 hardirqs last disabled at (125196): [<ffffffff85134044>] __schedule+0xea4/0x19f0
 softirqs last  enabled at (105334): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
 softirqs last disabled at (105332): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
 ---[ end trace 0000000000000000 ]---

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index adfa1f2a80a6..fda9140c0da4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2120,6 +2120,7 @@ void ice_dpll_init(struct ice_pf *pf)
 	struct ice_dplls *d = &pf->dplls;
 	int err = 0;
 
+	mutex_init(&d->lock);
 	err = ice_dpll_init_info(pf, cgu);
 	if (err)
 		goto err_exit;
@@ -2132,7 +2133,6 @@ void ice_dpll_init(struct ice_pf *pf)
 	err = ice_dpll_init_pins(pf, cgu);
 	if (err)
 		goto deinit_pps;
-	mutex_init(&d->lock);
 	if (cgu) {
 		err = ice_dpll_init_worker(pf);
 		if (err)
-- 
2.43.2


