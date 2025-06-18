Return-Path: <netdev+bounces-199082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6298ADEE19
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508447AC718
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABB2E9EB8;
	Wed, 18 Jun 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTFWxdFO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C72E92CF
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254088; cv=none; b=FPAqZIWOguPpkd5H+f5+ggWH428kfMcWu3XOLtyD3pComcL8LLzcJqCfhT8G3DiwY11jUnbhOvrDl8VOEu5r9Zdk0IqBWbH5eDEQCCxiYtkM2XLxD8HmowSW93zW/Nygoj7k/a24x1ktNYWw6qReX/SuSPhPhGC9COAOkEB2lvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254088; c=relaxed/simple;
	bh=cwSLHOZKVWKiSOwX2fZ1oB9Don0/TFoIe8ujDQT7v9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKvorikPDFcijveMeMc43BkXEhDlL09wnzISAu1Ot2uzMMCTEbFNKZ01oa1N4aUXqt0TdNMuqtBKpsLXugfX/zcd02jxA+CfJVreSweS9pZ91/0iNxmAB6yP3oYDi5FwF+1j13TZ0DOurFoN/NwE7Bko+sTB+zYUtKEI27cX8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTFWxdFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2AAC4CEE7;
	Wed, 18 Jun 2025 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750254087;
	bh=cwSLHOZKVWKiSOwX2fZ1oB9Don0/TFoIe8ujDQT7v9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTFWxdFOLMCMOTmod/3PKBqveXm9v3TtfQHJh18fffwpiaA8YEFmIpF1SUqAvxMS3
	 ChxqSLVwZM5M+tELK8vmJMq5X6u1HjF6wqhmjOMLPiJCpoT/b8k2Kw6fU/L7AOW7f5
	 669dhySp1wtxMI8zuvRmgoQ2ue0CWUfDnYCyCeLrLEX7940f8unkV8HCZuNRO9hybj
	 y8w47DycTv70J2Q5rBoglU3FrXai8H+yKFz+euDLNbFg1P5l23FojPh5GiV0drjS2r
	 LWjtooCOAbWJx0/6ZuTeztK6EJ3pwd4YTxtLvB2KwLQl0eWmPB1BIOP9BMhrXjekYZ
	 zYrUehElzYCNw==
Date: Wed, 18 Jun 2025 06:41:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 0/4] af_unix: Fix two OOB issues.
Message-ID: <20250618064126.2cf21b31@kernel.org>
In-Reply-To: <20250618043453.281247-1-kuni1840@gmail.com>
References: <20250618043453.281247-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 21:34:38 -0700 Kuniyuki Iwashima wrote:
> Patch 1 fixes issues that happen when multiple consumed OOB
> skbs are placed consecutively in the recv queue.
> 
> Patch 2 fixes an inconsistent behaviour that close()ing a socket
> with a consumed OOB skb at the head of the recv queue triggers
> -ECONNRESET on the peer's recv().

It appears to break the scm_rights tests, including a UAF.


# #  RUN           scm_rights.stream_listener.self_ref ...
# # scm_rights.c:176:self_ref:Expected 0 (0) == ret (4)
# # self_ref: Test terminated by assertion
# #          FAIL  scm_rights.stream_listener.self_ref
# not ok 25 scm_rights.stream_listener.self_ref
# #  RUN           scm_rights.stream_listener.triangle ...
# # scm_rights.c:176:triangle:Expected 0 (0) == ret (12)
# # triangle: Test terminated by assertion
# #          FAIL  scm_rights.stream_listener.triangle
# not ok 26 scm_rights.stream_listener.triangle
# #  RUN           scm_rights.stream_listener.cross_edge ...
# # scm_rights.c:176:cross_edge:Expected 0 (0) == ret (16)
# # cross_edge: Test terminated by assertion
# #          FAIL  scm_rights.stream_listener.cross_edge
# not ok 27 scm_rights.stream_listener.cross_edge
# #  RUN           scm_rights.stream_listener.backtrack_from_scc ...

[ 5716.340166][T26625] ==================================================================
[ 5716.340494][T26625] BUG: KASAN: slab-use-after-free in __unix_walk_scc+0x8e0/0xce0
[ 5716.340761][T26625] Read of size 8 at addr ffff88801d8c6fd0 by task kworker/u17:0/26625
[ 5716.341015][T26625] 
[ 5716.341103][T26625] CPU: 2 UID: 0 PID: 26625 Comm: kworker/u17:0 Not tainted 6.16.0-rc1-virtme #1 PREEMPT(full) 
[ 5716.341109][T26625] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 5716.341112][T26625] Workqueue: events_unbound __unix_gc
[ 5716.341118][T26625] Call Trace:
[ 5716.341120][T26625]  <TASK>
[ 5716.341123][T26625]  dump_stack_lvl+0x82/0xd0
[ 5716.341133][T26625]  print_address_description.constprop.0+0x2c/0x400
[ 5716.341141][T26625]  ? __unix_walk_scc+0x8e0/0xce0
[ 5716.341145][T26625]  print_report+0xb4/0x270
[ 5716.341148][T26625]  ? __unix_walk_scc+0x8e0/0xce0
[ 5716.341152][T26625]  ? kasan_addr_to_slab+0x25/0x80
[ 5716.341155][T26625]  ? __unix_walk_scc+0x8e0/0xce0
[ 5716.341158][T26625]  kasan_report+0xca/0x100
[ 5716.341163][T26625]  ? __unix_walk_scc+0x8e0/0xce0
[ 5716.341168][T26625]  __unix_walk_scc+0x8e0/0xce0
[ 5716.341174][T26625]  ? __pfx___unix_walk_scc+0x10/0x10
[ 5716.341178][T26625]  ? do_raw_spin_lock+0x130/0x270
[ 5716.341185][T26625]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 5716.341189][T26625]  ? lock_acquire+0x10c/0x170
[ 5716.341192][T26625]  ? __unix_gc+0x8b/0x400
[ 5716.341197][T26625]  __unix_gc+0x29f/0x400
[ 5716.341201][T26625]  ? __pfx___unix_gc+0x10/0x10
[ 5716.341207][T26625]  ? rcu_is_watching+0x12/0xc0
[ 5716.341215][T26625]  ? rcu_is_watching+0x12/0xc0
[ 5716.341219][T26625]  process_one_work+0xe43/0x1660
[ 5716.341228][T26625]  ? __pfx_process_one_work+0x10/0x10
[ 5716.341233][T26625]  ? assign_work+0x16c/0x240
[ 5716.341241][T26625]  worker_thread+0x591/0xcf0
[ 5716.341246][T26625]  ? __pfx_worker_thread+0x10/0x10
[ 5716.341250][T26625]  kthread+0x37e/0x600
[ 5716.341254][T26625]  ? __pfx_kthread+0x10/0x10
[ 5716.341256][T26625]  ? ret_from_fork+0x1b/0x320
[ 5716.341261][T26625]  ? __lock_release+0x5d/0x170
[ 5716.341265][T26625]  ? rcu_is_watching+0x12/0xc0
[ 5716.341268][T26625]  ? __pfx_kthread+0x10/0x10
[ 5716.341271][T26625]  ret_from_fork+0x240/0x320
[ 5716.341274][T26625]  ? __pfx_kthread+0x10/0x10
[ 5716.341276][T26625]  ret_from_fork_asm+0x1a/0x30
[ 5716.341286][T26625]  </TASK>
[ 5716.341288][T26625] 
[ 5716.347648][T26625] Allocated by task 12654:
[ 5716.347814][T26625]  kasan_save_stack+0x24/0x50
[ 5716.347983][T26625]  kasan_save_track+0x14/0x30
[ 5716.348171][T26625]  __kasan_slab_alloc+0x59/0x70
[ 5716.348348][T26625]  kmem_cache_alloc_noprof+0x10b/0x330
[ 5716.348522][T26625]  sk_prot_alloc.constprop.0+0x4e/0x1b0
[ 5716.348695][T26625]  sk_alloc+0x36/0x6c0
[ 5716.348823][T26625]  unix_create1+0x84/0x6f0
[ 5716.348991][T26625]  unix_create+0xcb/0x170
[ 5716.349119][T26625]  __sock_create+0x23c/0x6a0
[ 5716.349287][T26625]  __sys_socket+0x11a/0x1d0
[ 5716.349457][T26625]  __x64_sys_socket+0x72/0xb0
[ 5716.349634][T26625]  do_syscall_64+0xc1/0x380
[ 5716.349803][T26625]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 5716.350014][T26625] 
[ 5716.350098][T26625] Freed by task 12654:
[ 5716.350223][T26625]  kasan_save_stack+0x24/0x50
[ 5716.350390][T26625]  kasan_save_track+0x14/0x30
[ 5716.350586][T26625]  kasan_save_free_info+0x3b/0x60
[ 5716.350759][T26625]  __kasan_slab_free+0x38/0x50
[ 5716.350930][T26625]  kmem_cache_free+0x149/0x330
[ 5716.351099][T26625]  __sk_destruct+0x46e/0x780
[ 5716.351269][T26625]  unix_release_sock+0xa0e/0xf90
[ 5716.351440][T26625]  unix_release+0x8c/0xf0
[ 5716.351574][T26625]  __sock_release+0xa6/0x260
[ 5716.351763][T26625]  sock_close+0x18/0x20
[ 5716.351980][T26625]  __fput+0x35c/0xa80
[ 5716.352125][T26625]  fput_close_sync+0xdd/0x190
[ 5716.352293][T26625]  __x64_sys_close+0x7d/0xd0
[ 5716.352464][T26625]  do_syscall_64+0xc1/0x380
[ 5716.352724][T26625]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 5716.352933][T26625] 
[ 5716.353018][T26625] The buggy address belongs to the object at ffff88801d8c6940
[ 5716.353018][T26625]  which belongs to the cache UNIX-STREAM of size 1984
[ 5716.353553][T26625] The buggy address is located 1680 bytes inside of
[ 5716.353553][T26625]  freed 1984-byte region [ffff88801d8c6940, ffff88801d8c7100)
[ 5716.353951][T26625] 
[ 5716.354037][T26625] The buggy address belongs to the physical page:
[ 5716.354324][T26625] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d8c0
[ 5716.354621][T26625] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 5716.354966][T26625] flags: 0x80000000000040(head|node=0|zone=1)
[ 5716.355181][T26625] page_type: f5(slab)
[ 5716.355311][T26625] raw: 0080000000000040 ffff888005b4edc0 ffffea00002b7610 ffffea0000763210
[ 5716.355702][T26625] raw: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
[ 5716.356022][T26625] head: 0080000000000040 ffff888005b4edc0 ffffea00002b7610 ffffea0000763210
[ 5716.356330][T26625] head: 0000000000000000 00000000000e000e 00000000f5000000 0000000000000000
[ 5716.356727][T26625] head: 0080000000000003 ffffea0000763001 00000000ffffffff 00000000ffffffff
[ 5716.357027][T26625] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 5716.357434][T26625] page dumped because: kasan: bad access detected
[ 5716.357635][T26625] 
[ 5716.357716][T26625] Memory state around the buggy address:
[ 5716.357874][T26625]  ffff88801d8c6e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 5716.358115][T26625]  ffff88801d8c6f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 5716.358382][T26625] >ffff88801d8c6f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 5716.358720][T26625]                                                  ^
[ 5716.358921][T26625]  ffff88801d8c7000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 5716.359162][T26625]  ffff88801d8c7080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 5716.359506][T26625] ==================================================================
[ 5716.359805][T26625] Disabling lock debugging due to kernel taint

# # scm_rights.c:176:backtrack_from_scc:Expected 0 (0) == ret (22)
# # backtrack_from_scc: Test terminated by assertion
# #          FAIL  scm_rights.stream_listener.backtrack_from_scc
# not ok 28 scm_rights.stream_listener.backtrack_from_scc
-- 
pw-bot: cr

