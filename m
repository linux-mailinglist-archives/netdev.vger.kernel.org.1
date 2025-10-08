Return-Path: <netdev+bounces-228184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614EBC3F2D
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6BB19E4018
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B172F4A05;
	Wed,  8 Oct 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TBRYDYhG"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E22F3C34
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913594; cv=none; b=tJhmy0GI84lSrmpWOIWrfo+TWo4AjxS8Y6c3atD/j8zefKGhObeBss0d56w4jO28ce2WbiYP26he2r1gDgqdhU2CLeJZVzsF7AFyIgplMbDvyWVTHtgDj4zaD3RMtuHwGkohiff9IJT4tggfoUxF2GeqkFk9tC1tFWR23DHjRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913594; c=relaxed/simple;
	bh=coizfBfCGKgQ8fALILJU/iXDy4esAxUvjS43FaLCTTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YQiukqrKTSeSRPixv8PcqTJILjuYqa7iVQUpE4yIO2QoVmp8BugRLL/Ggs0r/u0/ZZg6BObLaP7PYEnC3rhbSc9FnDD3pNesxQTJ6vKoyvy4brMc37+rYn0DHq8Uc3vMWfw9CzQ9SDbqqFW6GzvXq8XRJ4CaCzqDnofW3e99qUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TBRYDYhG; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251008085308euoutp01c7253a250e445d47c72516454af002b9~seBWqbBl72977429774euoutp01j
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:53:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251008085308euoutp01c7253a250e445d47c72516454af002b9~seBWqbBl72977429774euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759913588;
	bh=kGrCnlGnP8ZDxxm+rsFGZarcVznvcQwAdEI88ve/ye0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TBRYDYhGqemTlsujP1djfw3sOdY/+at5cJondTpHPZ7kKso/5bk4j6vpHC6Kr0kYp
	 0dvO6jedcsbvDdRcwbk2zRL2ww80GocOd3ASSI+BWb9TIbmTM/RT+//Ofz97gOiyaO
	 DOALqE9XtRguDwa9hJDJj4b7NA4IZqyOa4rTPERE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251008085308eucas1p1690525b7ed2b58e06f80ff8201a42439~seBWFG-_j1228712287eucas1p1a;
	Wed,  8 Oct 2025 08:53:08 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251008085306eusmtip178f2c38c68106bb4643d24eaee98c3f0~seBUiI6Ry0375703757eusmtip1u;
	Wed,  8 Oct 2025 08:53:06 +0000 (GMT)
Message-ID: <4d4305f7-1ee1-415b-9bd5-407a85e60af8@samsung.com>
Date: Wed, 8 Oct 2025 10:53:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: KMSAN: uninit-value in eth_type_trans
To: Alexander Potapenko <glider@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Leon
	Romanovsky <leonro@nvidia.com>, mhklinux@outlook.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251008085308eucas1p1690525b7ed2b58e06f80ff8201a42439
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251007065234eucas1p2d75cf31bee782bce0dac9d591914a528
X-EPHeader: CA
X-CMS-RootMailID: 20251007065234eucas1p2d75cf31bee782bce0dac9d591914a528
References: <20250925223656.1894710-1-nogikh@google.com>
	<CGME20251007065234eucas1p2d75cf31bee782bce0dac9d591914a528@eucas1p2.samsung.com>
	<CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>

Hi

On 07.10.2025 08:51, Alexander Potapenko wrote:
> On Fri, Sep 26, 2025 at 12:36 AM Aleksandr Nogikh <nogikh@google.com> wrote:
>> Hello net developers,
> CCing DMA developers, as this seems to be a generic problem.
> See the question below, after the KMSAN report.

Thanks for this report!

>> I hit the following kernel crash when I try to boot a CONFIG_KMSAN=y kernel on qemu:
>>
>> KMSAN: uninit-value in eth_type_trans
>>
>> Could you please have a look?
>>
>> Kernel: torvalds
>> Commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
>> Config: https://protect2.fireeye.com/v1/url?k=53229ed1-0cb9a7ce-5323159e-000babdfecba-dfefb775995a4321&q=1&e=a1f2777b-91b5-43b3-8580-011d41f4d75a&u=https%3A%2F%2Fraw.githubusercontent.com%2Fgoogle%2Fsyzkaller%2Frefs%2Fheads%2Fmaster%2Fdashboard%2Fconfig%2Flinux%2Fupstream-kmsan.config
>>
>> Qemu command to reproduce:
>>
>> qemu-system-x86_64 -m 8G -smp 2,sockets=2,cores=1 -machine pc-q35-10.0 \
>> -enable-kvm -display none -serial stdio -snapshot \
>> -device virtio-blk-pci,drive=myhd -drive file=~/buildroot_amd64_2024.09,format=raw,if=none,id=myhd \
>> -kernel ~/linux/arch/x86/boot/bzImage -append "root=/dev/vda1" -cpu max \
>> -net nic,model=e1000 -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22
>>
>> The command used the buildroot image below:
>> $ wget 'https://protect2.fireeye.com/v1/url?k=b0fed9f8-ef65e0e7-b0ff52b7-000babdfecba-ea62e0c7e52f3737&q=1&e=a1f2777b-91b5-43b3-8580-011d41f4d75a&u=https%3A%2F%2Fstorage.googleapis.com%2Fsyzkaller%2Fimages%2Fbuildroot_amd64_2024.09.gz'
>> $ gunzip buildroot_amd64_2024.09.gz
>>
>> Full symbolized report:
>>
>> BUG: KMSAN: uninit-value in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>> BUG: KMSAN: uninit-value in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>>   eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>>   eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>>   e1000_receive_skb drivers/net/ethernet/intel/e1000/e1000_main.c:4005 [inline]
>>   e1000_clean_rx_irq+0x1256/0x1cf0 drivers/net/ethernet/intel/e1000/e1000_main.c:4465
>>   e1000_clean+0x1e4b/0x5f10 drivers/net/ethernet/intel/e1000/e1000_main.c:3807
>>   __napi_poll+0xda/0x850 net/core/dev.c:7506
>>   napi_poll net/core/dev.c:7569 [inline]
>>   net_rx_action+0xa56/0x1b00 net/core/dev.c:7696
>>   handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
>>   __do_softirq kernel/softirq.c:613 [inline]
>>   invoke_softirq kernel/softirq.c:453 [inline]
>>   __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
>>   irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
>>   common_interrupt+0x99/0xb0 arch/x86/kernel/irq.c:318
>>   asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
>>   native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
>>   pv_native_safe_halt+0x17/0x20 arch/x86/kernel/paravirt.c:81
>>   arch_safe_halt arch/x86/kernel/process.c:756 [inline]
>>   default_idle+0xd/0x20 arch/x86/kernel/process.c:757
>>   arch_cpu_idle+0xd/0x20 arch/x86/kernel/process.c:794
>>   default_idle_call+0x41/0x70 kernel/sched/idle.c:122
>>   cpuidle_idle_call kernel/sched/idle.c:190 [inline]
>>   do_idle+0x1dc/0x790 kernel/sched/idle.c:330
>>   cpu_startup_entry+0x60/0x80 kernel/sched/idle.c:428
>>   rest_init+0x1df/0x260 init/main.c:744
>>   start_kernel+0x76e/0x960 init/main.c:1097
>>   x86_64_start_reservations+0x28/0x30 arch/x86/kernel/head64.c:307
>>   x86_64_start_kernel+0x139/0x140 arch/x86/kernel/head64.c:288
>>   common_startup_64+0x13e/0x147
>>
>> Uninit was stored to memory at:
>>   skb_put_data include/linux/skbuff.h:2753 [inline]
>>   e1000_copybreak drivers/net/ethernet/intel/e1000/e1000_main.c:4339 [inline]
>>   e1000_clean_rx_irq+0x870/0x1cf0 drivers/net/ethernet/intel/e1000/e1000_main.c:4384
>>   e1000_clean+0x1e4b/0x5f10 drivers/net/ethernet/intel/e1000/e1000_main.c:3807
>>   __napi_poll+0xda/0x850 net/core/dev.c:7506
>>   napi_poll net/core/dev.c:7569 [inline]
>>   net_rx_action+0xa56/0x1b00 net/core/dev.c:7696
>>   handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
>>   __do_softirq kernel/softirq.c:613 [inline]
>>   invoke_softirq kernel/softirq.c:453 [inline]
>>   __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
>>   irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
>>   common_interrupt+0x99/0xb0 arch/x86/kernel/irq.c:318
>>   asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
>>
>> Uninit was stored to memory at:
>>   swiotlb_bounce+0x470/0x640 kernel/dma/swiotlb.c:-1
>>   __swiotlb_sync_single_for_cpu+0x9e/0xc0 kernel/dma/swiotlb.c:1567
>>   swiotlb_sync_single_for_cpu include/linux/swiotlb.h:279 [inline]
>>   dma_direct_sync_single_for_cpu kernel/dma/direct.h:77 [inline]
>>   __dma_sync_single_for_cpu+0x50d/0x710 kernel/dma/mapping.c:370
>>   dma_sync_single_for_cpu include/linux/dma-mapping.h:381 [inline]
>>   e1000_copybreak drivers/net/ethernet/intel/e1000/e1000_main.c:4336 [inline]
>>   e1000_clean_rx_irq+0x7dc/0x1cf0 drivers/net/ethernet/intel/e1000/e1000_main.c:4384
>>   e1000_clean+0x1e4b/0x5f10 drivers/net/ethernet/intel/e1000/e1000_main.c:3807
>>   __napi_poll+0xda/0x850 net/core/dev.c:7506
>>   napi_poll net/core/dev.c:7569 [inline]
>>   net_rx_action+0xa56/0x1b00 net/core/dev.c:7696
>>   handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
>>   __do_softirq kernel/softirq.c:613 [inline]
>>   invoke_softirq kernel/softirq.c:453 [inline]
>>   __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
>>   irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
>>   common_interrupt+0x99/0xb0 arch/x86/kernel/irq.c:318
>>   asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
>>
>> Uninit was stored to memory at:
>>   swiotlb_bounce+0x470/0x640 kernel/dma/swiotlb.c:-1
>>   swiotlb_tbl_map_single+0x2956/0x2b20 kernel/dma/swiotlb.c:1439
>>   swiotlb_map+0x349/0x1050 kernel/dma/swiotlb.c:1584
>>   dma_direct_map_page kernel/dma/direct.h:-1 [inline]
>>   dma_map_page_attrs+0x614/0xef0 kernel/dma/mapping.c:169
>>   dma_map_single_attrs include/linux/dma-mapping.h:469 [inline]
>>   e1000_alloc_rx_buffers+0x96d/0x1600 drivers/net/ethernet/intel/e1000/e1000_main.c:4616
>>   e1000_configure+0x16fe/0x1930 drivers/net/ethernet/intel/e1000/e1000_main.c:377
>>   e1000_open+0x985/0x14d0 drivers/net/ethernet/intel/e1000/e1000_main.c:1388
>>   __dev_open+0x7c2/0xc40 net/core/dev.c:1682
>>   __dev_change_flags+0x3ae/0x9b0 net/core/dev.c:9549
>>   netif_change_flags+0x8d/0x1e0 net/core/dev.c:9612
>>   dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
>>   devinet_ioctl+0x162d/0x2570 net/ipv4/devinet.c:1199
>>   inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1001
>>   sock_do_ioctl+0x9f/0x480 net/socket.c:1238
>>   sock_ioctl+0x70b/0xd60 net/socket.c:1359
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:598 [inline]
>>   __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:584
>>   __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
>>   x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:17
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Uninit was created at:
>>   __alloc_frozen_pages_noprof+0x648/0xe80 mm/page_alloc.c:5171
>>   __alloc_pages_noprof+0x41/0xd0 mm/page_alloc.c:5182
>>   __page_frag_cache_refill+0x57/0x2a0 mm/page_frag_cache.c:59
>>   __page_frag_alloc_align+0xd0/0x690 mm/page_frag_cache.c:103
>>   __napi_alloc_frag_align net/core/skbuff.c:248 [inline]
>>   __netdev_alloc_frag_align+0x1b7/0x1f0 net/core/skbuff.c:269
>>   netdev_alloc_frag include/linux/skbuff.h:3408 [inline]
>>   e1000_alloc_frag drivers/net/ethernet/intel/e1000/e1000_main.c:2074 [inline]
>>   e1000_alloc_rx_buffers+0x276/0x1600 drivers/net/ethernet/intel/e1000/e1000_main.c:4584
>>   e1000_configure+0x16fe/0x1930 drivers/net/ethernet/intel/e1000/e1000_main.c:377
>>   e1000_open+0x985/0x14d0 drivers/net/ethernet/intel/e1000/e1000_main.c:1388
>>   __dev_open+0x7c2/0xc40 net/core/dev.c:1682
>>   __dev_change_flags+0x3ae/0x9b0 net/core/dev.c:9549
>>   netif_change_flags+0x8d/0x1e0 net/core/dev.c:9612
>>   dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
>>   devinet_ioctl+0x162d/0x2570 net/ipv4/devinet.c:1199
>>   inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1001
>>   sock_do_ioctl+0x9f/0x480 net/socket.c:1238
>>   sock_ioctl+0x70b/0xd60 net/socket.c:1359
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:598 [inline]
>>   __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:584
>>   __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
>>   x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:17
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Folks, as far as I understand, dma_direct_sync_single_for_cpu() and
> dma_direct_sync_single_for_device() are the places where we send data
> to or from the device.
> Should we add KMSAN annotations to those functions to catch infoleaks
> and mark data from devices as initialized?

I confirm the issue and indeed dma_sync* function family requires kmsan 
annotations. Those should be added in the same place as trace_dma_* and 
debug_dma_* calls in kernel/dma/mapping.c. I briefly looked at the 
existing annotations there and found that the existing 
kmsan_handle_dma() calls also should be moved from dma_map* to 
dma_unmap* set of functions, because only after them it is safe to 
access the DMA transferred data by the CPU.

The major problem however is that in dma_unmap_page() (or 
dma_unmap_phys() in linus/master) and __dma_sync_single*() there is no 
access to original page pointer needed by kmsan hook. The only way to 
fix this is probably to add .dma_to_phys() method to struct dma_map_ops 
and all its providers.


I made a quick PoC based on dma-direct and it resolved the issue 
reported in this thread on QEMU system:

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 56de28a3b179..98ba1a6b5c84 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -171,7 +171,6 @@ dma_addr_t dma_map_page_attrs(struct device *dev, 
struct page *page,
                 addr = iommu_dma_map_page(dev, page, offset, size, dir, 
attrs);
         else
                 addr = ops->map_page(dev, page, offset, size, dir, attrs);
-       kmsan_handle_dma(page, offset, size, dir);
         trace_dma_map_page(dev, page_to_phys(page) + offset, addr, 
size, dir,
                            attrs);
         debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
@@ -180,12 +179,30 @@ dma_addr_t dma_map_page_attrs(struct device *dev, 
struct page *page,
  }
  EXPORT_SYMBOL(dma_map_page_attrs);

+#include <linux/dma-direct.h>
+
+static void kmsan_handle_direct_dma(struct device *dev, dma_addr_t addr,
+               size_t size, enum dma_data_direction dir)
+{
+       phys_addr_t phys = dma_to_phys(dev, addr);
+       struct page *page = pfn_to_page(PHYS_PFN(phys));
+       size_t offset = offset_in_page(phys);
+
+       kmsan_handle_dma(page, offset, size, dir);
+}
+
  void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t 
size,
                 enum dma_data_direction dir, unsigned long attrs)
  {
         const struct dma_map_ops *ops = get_dma_ops(dev);

         BUG_ON(!valid_dma_direction(dir));
+
+       if (dma_map_direct(dev, ops))
+               kmsan_handle_direct_dma(dev, addr, size, dir);
+       else
+               BUG();
+
         if (dma_map_direct(dev, ops) ||
             arch_dma_unmap_page_direct(dev, addr + size))
                 dma_direct_unmap_page(dev, addr, size, dir, attrs);
@@ -218,7 +235,6 @@ static int __dma_map_sg_attrs(struct device *dev, 
struct scatterlist *sg,
                 ents = ops->map_sg(dev, sg, nents, dir, attrs);

         if (ents > 0) {
-               kmsan_handle_dma_sg(sg, nents, dir);
                 trace_dma_map_sg(dev, sg, nents, ents, dir, attrs);
                 debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
         } else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
@@ -306,6 +322,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct 
scatterlist *sg,
         const struct dma_map_ops *ops = get_dma_ops(dev);

         BUG_ON(!valid_dma_direction(dir));
+       kmsan_handle_dma_sg(sg, nents, dir);
         trace_dma_unmap_sg(dev, sg, nents, dir, attrs);
         debug_dma_unmap_sg(dev, sg, nents, dir);
         if (dma_map_direct(dev, ops) ||
@@ -366,6 +383,12 @@ void __dma_sync_single_for_cpu(struct device *dev, 
dma_addr_t addr, size_t size,
         const struct dma_map_ops *ops = get_dma_ops(dev);

         BUG_ON(!valid_dma_direction(dir));
+
+       if (dma_map_direct(dev, ops))
+               kmsan_handle_direct_dma(dev, addr, size, dir);
+       else
+               BUG();
+
         if (dma_map_direct(dev, ops))
                 dma_direct_sync_single_for_cpu(dev, addr, size, dir);
         else if (use_dma_iommu(dev))
@@ -406,6 +429,7 @@ void __dma_sync_sg_for_cpu(struct device *dev, 
struct scatterlist *sg,
                 iommu_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
         else if (ops->sync_sg_for_cpu)
                 ops->sync_sg_for_cpu(dev, sg, nelems, dir);
+       kmsan_handle_dma_sg(sg, nelems, dir);
         trace_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
         debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


