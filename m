Return-Path: <netdev+bounces-63465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B6282D2FB
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 02:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12091C20905
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 01:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1615B1;
	Mon, 15 Jan 2024 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zb4b7mFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0315AC
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705282522; x=1736818522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pMFnQJRSnXPx/Q3Q+KzUmXEGn/iDIuLSdOjoro0tqvM=;
  b=Zb4b7mFJ9D08BUtUq7xUmRsXj2HVugfuTC6CgV2x6fZGZyEDTIzvU56z
   pJSukKBLsxKO1tO2yx56Gum7y0/DU0sHv8PNl/f5qm/iTEe4SKq+CxQKX
   F/RHGw39TW4UxoAMXT5ah5ZjlOZ/YmaPaAXnT2B8aUK9DnHtQVmEwNd/f
   0EBEeDnouLBNzaUGxQZaAfNKQx7jYCpHBx/+3KBwoKu+ktGs84r/Wwqq/
   0bumgJ+ro223pQ8M/0/85/XRy/rEHqtjJ+9veOMkG+kkVYLvCM5hABG5a
   chUntMmMRp5NT7ub8ln+jVxotu42QzQBq2mOup2JnB6aJsX08VBAD9tmh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6266305"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6266305"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="926971943"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="926971943"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2024 17:35:18 -0800
From: Zhu Yanjun <yanjun.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
Date: Mon, 15 Jan 2024 09:29:18 +0800
Message-Id: <20240115012918.3081203-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Some devices emulate the virtio_net hardwares. When virtio_net
driver sends commands to the emulated hardware, normally the
hardware needs time to response. Sometimes the time is very
long. Thus, the following will appear. Then the whole system
will hang.
The similar problems also occur in Intel NICs and Mellanox NICs.
As such, the similar solution is borrowed from them. A timeout
value is added and the timeout value as large as possible is set
to ensure that the driver gets the maximum possible response from
the hardware.

"
[  213.795860] watchdog: BUG: soft lockup - CPU#108 stuck for 26s! [(udev-worker):3157]
[  213.796114] Modules linked in: virtio_net(+) net_failover failover qrtr rfkill sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp iTCO_wdt rapl intel_pmc_bxt dax_hmem iTCO_vendor_support vfat cxl_acpi intel_cstate pmt_telemetry pmt_class intel_sdsi joydev intel_uncore cxl_core fat pcspkr mei_me isst_if_mbox_pci isst_if_mmio idxd i2c_i801 isst_if_common mei intel_vsec idxd_bus i2c_smbus i2c_ismt ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter pfr_telemetry pfr_update fuse loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 bnxt_en sha256_ssse3 sha1_ssse3 nvme ast nvme_core i2c_algo_bit wmi pinctrl_emmitsburg scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
[  213.796194] irq event stamp: 67740
[  213.796195] hardirqs last  enabled at (67739): [<ffffffff8c2015ca>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  213.796203] hardirqs last disabled at (67740): [<ffffffff8c14108e>] sysvec_apic_timer_interrupt+0xe/0x90
[  213.796208] softirqs last  enabled at (67686): [<ffffffff8b12115e>] __irq_exit_rcu+0xbe/0xe0
[  213.796214] softirqs last disabled at (67681): [<ffffffff8b12115e>] __irq_exit_rcu+0xbe/0xe0
[  213.796217] CPU: 108 PID: 3157 Comm: (udev-worker) Kdump: loaded Not tainted 6.7.0+ #9
[  213.796220] Hardware name: Intel Corporation M50FCP2SBSTD/M50FCP2SBSTD, BIOS SE5C741.86B.01.01.0001.2211140926 11/14/2022
[  213.796221] RIP: 0010:virtqueue_get_buf_ctx_split+0x8d/0x110
[  213.796228] Code: 89 df e8 26 fe ff ff 0f b7 43 50 83 c0 01 66 89 43 50 f6 43 78 01 75 12 80 7b 42 00 48 8b 4b 68 8b 53 58 74 0f 66 87 44 51 04 <48> 89 e8 5b 5d c3 cc cc cc cc 66 89 44 51 04 0f ae f0 48 89 e8 5b
[  213.796230] RSP: 0018:ff4bbb362306f9b0 EFLAGS: 00000246
[  213.796233] RAX: 0000000000000000 RBX: ff2f15095896f000 RCX: 0000000000000001
[  213.796235] RDX: 0000000000000000 RSI: ff4bbb362306f9cc RDI: ff2f15095896f000
[  213.796236] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  213.796237] R10: 0000000000000003 R11: ff2f15095893cc40 R12: 0000000000000002
[  213.796239] R13: 0000000000000004 R14: 0000000000000000 R15: ff2f1509534f3000
[  213.796240] FS:  00007f775847d0c0(0000) GS:ff2f1528bac00000(0000) knlGS:0000000000000000
[  213.796242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  213.796243] CR2: 0000557f987b6e70 CR3: 0000002098602006 CR4: 0000000000f71ef0
[  213.796245] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  213.796246] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  213.796247] PKRU: 55555554
[  213.796249] Call Trace:
[  213.796250]  <IRQ>
[  213.796252]  ? watchdog_timer_fn+0x1c0/0x220
[  213.796258]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  213.796261]  ? __hrtimer_run_queues+0x1af/0x380
[  213.796269]  ? hrtimer_interrupt+0xf8/0x230
[  213.796274]  ? __sysvec_apic_timer_interrupt+0x64/0x1a0
[  213.796279]  ? sysvec_apic_timer_interrupt+0x6d/0x90
[  213.796282]  </IRQ>
[  213.796284]  <TASK>
[  213.796285]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  213.796293]  ? virtqueue_get_buf_ctx_split+0x8d/0x110
[  213.796297]  virtnet_send_command+0x18a/0x1f0 [virtio_net]
[  213.796310]  _virtnet_set_queues+0xc6/0x120 [virtio_net]
[  213.796319]  virtnet_probe+0xa06/0xd50 [virtio_net]
[  213.796328]  virtio_dev_probe+0x195/0x230
[  213.796333]  really_probe+0x19f/0x400
[  213.796338]  ? __pfx___driver_attach+0x10/0x10
[  213.796340]  __driver_probe_device+0x78/0x160
[  213.796343]  driver_probe_device+0x1f/0x90
[  213.796346]  __driver_attach+0xd6/0x1d0
[  213.796349]  bus_for_each_dev+0x8c/0xe0
[  213.796355]  bus_add_driver+0x119/0x220
[  213.796359]  driver_register+0x59/0x100
[  213.796362]  ? __pfx_virtio_net_driver_init+0x10/0x10 [virtio_net]
[  213.796369]  virtio_net_driver_init+0x8e/0xff0 [virtio_net]
[  213.796375]  do_one_initcall+0x6f/0x380
[  213.796384]  do_init_module+0x60/0x240
[  213.796388]  init_module_from_file+0x86/0xc0
[  213.796396]  idempotent_init_module+0x129/0x2c0
[  213.796406]  __x64_sys_finit_module+0x5e/0xb0
[  213.796409]  do_syscall_64+0x60/0xe0
[  213.796415]  ? do_syscall_64+0x6f/0xe0
[  213.796418]  ? lockdep_hardirqs_on_prepare+0xe4/0x1a0
[  213.796424]  ? do_syscall_64+0x6f/0xe0
[  213.796427]  ? do_syscall_64+0x6f/0xe0
[  213.796431]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  213.796435] RIP: 0033:0x7f7758f279cd
[  213.796465] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 33 e4 0c 00 f7 d8 64 89 01 48
[  213.796467] RSP: 002b:00007ffe2cad8738 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  213.796469] RAX: ffffffffffffffda RBX: 0000557f987a8180 RCX: 00007f7758f279cd
[  213.796471] RDX: 0000000000000000 RSI: 00007f77593e5453 RDI: 000000000000000f
[  213.796472] RBP: 00007f77593e5453 R08: 0000000000000000 R09: 00007ffe2cad8860
[  213.796473] R10: 000000000000000f R11: 0000000000000246 R12: 0000000000020000
[  213.796475] R13: 0000557f9879f8e0 R14: 0000000000000000 R15: 0000557f98783aa0
[  213.796482]  </TASK>
"

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 51b1868d2f22..28b7dd917a43 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2468,7 +2468,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 {
 	struct scatterlist *sgs[4], hdr, stat;
 	unsigned out_num = 0, tmp;
-	int ret;
+	int ret, timeout = 200;
 
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
@@ -2502,8 +2502,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
 	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
+	       !virtqueue_is_broken(vi->cvq)) {
+		if (timeout)
+			timeout--;
+		else
+			return false; /* long time no response */
+
 		cpu_relax();
+	}
 
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
-- 
2.42.0


