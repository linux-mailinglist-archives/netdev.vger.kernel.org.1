Return-Path: <netdev+bounces-125534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF84C96D936
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB5B285BFA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3C19E836;
	Thu,  5 Sep 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsN0mBof"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A119E810
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540281; cv=none; b=jI2/PsJSHBzM6kFAJlDl73pvBJcmxhvnWJ8dvXHDkJypLSmEX3fC9OFn0mtTz1CzsROMwWfa22GFwQjjNDnPFo07oPDSk1NqnTnrCneZ2v3mkWLentRyoFk+S3StVbs1I2BZZ9D0LS8EKaO1cRILmSClYVX5Y6ueRJ831LGsCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540281; c=relaxed/simple;
	bh=UbHaH9zy3deCKMnFJJK+O+ybZULQsfB0yKPcJ7kBYjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ne8+nnDTBySjV4j52vmgRY57hfUk89gh1Hvoc0P2VFF7k1sLoJe1s9oXRC1d6AjzhTR+rIHXfZkFMG87YBl+hauYtYWZMVgwXgGVxLaO6dtEhJYC2Huzlqbkb5O7In9UG9PQ0mQ2Guw9i9N5Rx0YOFC4KMdFI4MAozcTfH3KVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsN0mBof; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725540279; x=1757076279;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UbHaH9zy3deCKMnFJJK+O+ybZULQsfB0yKPcJ7kBYjg=;
  b=VsN0mBofp0H7SjtDVG8hXP34ZINz2XHXzOei8exkvUxYDwHWcQfVlNV2
   9x3nzylvJDQqaDzRZwG65LINwOC8RND9XmwllA6ziZeNrJmDLVWPy3pgd
   nIa9YZjckSUavrP5ebcXet/xOhdHdCbttib+wka+ZwGcJDJ05NsUpIbse
   QQJuhlqaZ8/oNdSUCofRN8IR0h5jJIck1XTsGd5RJvIPRxpf6eIs/UV1h
   uhL/RRJRVack04UTHwsoLu3SNMWXTDEPCTFyfnKpxqOjt4SQSYdA7Zd6F
   B2HtAQ2oOUHTIcWVQ5dvST8zC0dNCFBEEWpOvRrKL6PMmckdos6ptPZdx
   Q==;
X-CSE-ConnectionGUID: uqSct6zHR62qBI48o33IzQ==
X-CSE-MsgGUID: n6uqUCZpRYuE749/dE4SnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23759269"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="23759269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:44:38 -0700
X-CSE-ConnectionGUID: Mkf80VpFTr6fU3Vvv1z+mA==
X-CSE-MsgGUID: iyOeZss9SIGJcqwGx2AFKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65594705"
Received: from gargmani-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:44:36 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH net v5 2/2] net: sched: use RCU read-side critical
 section in taprio_dump()
In-Reply-To: <20240904120842.3426084-2-dmantipov@yandex.ru>
References: <20240904120842.3426084-1-dmantipov@yandex.ru>
 <20240904120842.3426084-2-dmantipov@yandex.ru>
Date: Thu, 05 Sep 2024 09:44:32 -0300
Message-ID: <87mskmnubz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Fix possible use-after-free in 'taprio_dump()' by adding RCU
> read-side critical section there. Never seen on x86 but
> found on a KASAN-enabled arm64 system when investigating
> https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa:
>
> [T15862] BUG: KASAN: slab-use-after-free in taprio_dump+0xa0c/0xbb0
> [T15862] Read of size 4 at addr ffff0000d4bb88f8 by task repro/15862
> [T15862]
> [T15862] CPU: 0 UID: 0 PID: 15862 Comm: repro Not tainted 6.11.0-rc1-00293-gdefaf1a2113a-dirty #2
> [T15862] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20240524-5.fc40 05/24/2024
> [T15862] Call trace:
> [T15862]  dump_backtrace+0x20c/0x220
> [T15862]  show_stack+0x2c/0x40
> [T15862]  dump_stack_lvl+0xf8/0x174
> [T15862]  print_report+0x170/0x4d8
> [T15862]  kasan_report+0xb8/0x1d4
> [T15862]  __asan_report_load4_noabort+0x20/0x2c
> [T15862]  taprio_dump+0xa0c/0xbb0
> [T15862]  tc_fill_qdisc+0x540/0x1020
> [T15862]  qdisc_notify.isra.0+0x330/0x3a0
> [T15862]  tc_modify_qdisc+0x7b8/0x1838
> [T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
> [T15862]  netlink_rcv_skb+0x1f8/0x3d4
> [T15862]  rtnetlink_rcv+0x28/0x40
> [T15862]  netlink_unicast+0x51c/0x790
> [T15862]  netlink_sendmsg+0x79c/0xc20
> [T15862]  __sock_sendmsg+0xe0/0x1a0
> [T15862]  ____sys_sendmsg+0x6c0/0x840
> [T15862]  ___sys_sendmsg+0x1ac/0x1f0
> [T15862]  __sys_sendmsg+0x110/0x1d0
> [T15862]  __arm64_sys_sendmsg+0x74/0xb0
> [T15862]  invoke_syscall+0x88/0x2e0
> [T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
> [T15862]  do_el0_svc+0x44/0x60
> [T15862]  el0_svc+0x50/0x184
> [T15862]  el0t_64_sync_handler+0x120/0x12c
> [T15862]  el0t_64_sync+0x190/0x194
> [T15862]
> [T15862] Allocated by task 15857:
> [T15862]  kasan_save_stack+0x3c/0x70
> [T15862]  kasan_save_track+0x20/0x3c
> [T15862]  kasan_save_alloc_info+0x40/0x60
> [T15862]  __kasan_kmalloc+0xd4/0xe0
> [T15862]  __kmalloc_cache_noprof+0x194/0x334
> [T15862]  taprio_change+0x45c/0x2fe0
> [T15862]  tc_modify_qdisc+0x6a8/0x1838
> [T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
> [T15862]  netlink_rcv_skb+0x1f8/0x3d4
> [T15862]  rtnetlink_rcv+0x28/0x40
> [T15862]  netlink_unicast+0x51c/0x790
> [T15862]  netlink_sendmsg+0x79c/0xc20
> [T15862]  __sock_sendmsg+0xe0/0x1a0
> [T15862]  ____sys_sendmsg+0x6c0/0x840
> [T15862]  ___sys_sendmsg+0x1ac/0x1f0
> [T15862]  __sys_sendmsg+0x110/0x1d0
> [T15862]  __arm64_sys_sendmsg+0x74/0xb0
> [T15862]  invoke_syscall+0x88/0x2e0
> [T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
> [T15862]  do_el0_svc+0x44/0x60
> [T15862]  el0_svc+0x50/0x184
> [T15862]  el0t_64_sync_handler+0x120/0x12c
> [T15862]  el0t_64_sync+0x190/0x194
> [T15862]
> [T15862] Freed by task 6192:
> [T15862]  kasan_save_stack+0x3c/0x70
> [T15862]  kasan_save_track+0x20/0x3c
> [T15862]  kasan_save_free_info+0x4c/0x80
> [T15862]  poison_slab_object+0x110/0x160
> [T15862]  __kasan_slab_free+0x3c/0x74
> [T15862]  kfree+0x134/0x3c0
> [T15862]  taprio_free_sched_cb+0x18c/0x220
> [T15862]  rcu_core+0x920/0x1b7c
> [T15862]  rcu_core_si+0x10/0x1c
> [T15862]  handle_softirqs+0x2e8/0xd64
> [T15862]  __do_softirq+0x14/0x20
>
> Fixes: 18cdd2f0998a ("net/sched: taprio: taprio_dump and taprio_change are protected by rtnl_mutex")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v5: add Fixes: and resend due to series change
> v4: redesign to preserve original code as much as possible,
>     adjust commit message and subject to target net tree
> v3: tweak commit message as suggested by Vinicius
> v2: added to the series
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>



Cheers,
-- 
Vinicius

