Return-Path: <netdev+bounces-124986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C396B816
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB01C21E29
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA35433C8;
	Wed,  4 Sep 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuvVeitN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5591EBFEB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445062; cv=none; b=qW9u/iLaFZjYRlAsWa2srJ0Z0DfV7ZiKbR3goD3qpjKh9YGpoqUDUSmtTUTXmHo6cUD3UFvsa9e9kYbxbLY+0oDjkcOuWLKdHEHayppx9Ag8dK11O/4mkqJH/62NGwbKU8Pe3oXRVudzZyUvL0k7vC+fiXEjLKn2NhKPkV/KwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445062; c=relaxed/simple;
	bh=0zY6xbeSVORsVRxwGmqaCqkz2FyPQEUKymzV5IAe9gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvOOQVAF7k1sRUnO/5cB3t0UXymvBReBC/AWO+HDetdryfXsF6DK+C0PDhuFzfk+8oZu1kNp0I+VdD78nm7EVpEcBoA/bo49VthfjQtfE9nn5I3O98Gl8vCvrOXwiFzUKEQMEueDuhmrxvUJBAnxc++frLFkifhFGYtX6A1YQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuvVeitN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB772C4CEC2;
	Wed,  4 Sep 2024 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445062;
	bh=0zY6xbeSVORsVRxwGmqaCqkz2FyPQEUKymzV5IAe9gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuvVeitNRGPe/5Ovp2FF1u4MQNFn+8FnG2f+ZT8Tfqfx8gjPam504UmG6KjzVKOlN
	 s4VqMv3rOH84Mr9gVJTCwIutik2L23uC/ZcpTcKb/WZLVkyWbkz0oR0unFSeLYvqe2
	 tOjxTveNBCVwegejAn1eDx7rwqlo9NI7kGcurbxTcMR6IYoTs2aeOEKXdKvOTV7Tse
	 M1JmujJg/O3HpGCr7p2WsTlFzB61+ow9UbCFOdGTB7XoZ/TbLvoVcebE768KRBeNlV
	 107CtzT6GZl7gBGUF2pxilMFF9HnCHcJyGEO0DmWJFH+HlVEH3Z24evjYzw23p5DoC
	 0Sg3Cun5l0psw==
Date: Wed, 4 Sep 2024 11:17:38 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net v4 3/3] net: sched: use RCU read-side critical
 section in taprio_dump()
Message-ID: <20240904101738.GI4792@kernel.org>
References: <20240903140708.3122263-1-dmantipov@yandex.ru>
 <20240903140708.3122263-3-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140708.3122263-3-dmantipov@yandex.ru>

On Tue, Sep 03, 2024 at 05:07:08PM +0300, Dmitry Antipov wrote:
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

Hi Dmitry,

As a fix for net, there should be a Fixes tag here,
indicating the first commit in which this bug manifested.
This can be the first commit in the tree, if the
bug has been there since then.

If the patch-set is not going to be resent, it is probably
sufficient to just reply with one here. And it may be a good
idea to do so regardless.

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

