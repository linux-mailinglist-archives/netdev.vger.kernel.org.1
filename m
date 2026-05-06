Return-Path: <netdev+bounces-284708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKxiKwHZ+ml8TQMAu9opvQ
	(envelope-from <netdev+bounces-284708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:00:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F74D66BD
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFEF3303F70C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 06:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF830AD15;
	Wed,  6 May 2026 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENyEmRaN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87E3093B5;
	Wed,  6 May 2026 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778047209; cv=none; b=SmMZ/8yh+o9kVKxIDXVe/zaDnQVedjqUHyMuoSsThMoolkmIsSTQAqOo8w2w9Sg23gEthcm5wVNQ4jGCg79dx3t4/yGjrq4TJaSid1hSzsbG3+zAfQyY0+3ZkPBZEw/s8ydVIgZIONuwEEolSo3vYFPd4a+IhgNiqYQ9LiaRGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778047209; c=relaxed/simple;
	bh=Gm/pGcV1sMJnP2uo3/lczqZMuD1TJ38PM5cdRuuHdMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfb0PE9ToqoZKlSm6yu+DjTRzoTx72c5UjnGLQQTQhCrq/KmpqU9IIi4gQi3yJ7C4y1RmexpabH5CPBXqdPTWosCQTsZ9hnqWN2fNQMrKO3zgkgtwFzbHz0Q6tikBHoYw+0NR9CMkWi1qQIrwvj/bjP0AQvp/52PVwDuVAOP/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENyEmRaN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778047207; x=1809583207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gm/pGcV1sMJnP2uo3/lczqZMuD1TJ38PM5cdRuuHdMk=;
  b=ENyEmRaN5u7bbKfNYP061AHINf0cVFePuG66wyRaHuSAJcufNe6pBm7i
   PaaKf7AAvvA3jEcwICQ/NRdH23TuGnYcYM2Zor+/nBEJLmwqIpE9SP/od
   MtisccHylSw87UtrOAAoNqftFwzWvmeReCILhXlJ57OwNELIUiZeXTKlQ
   EuADYDDNKudFEl+RyXgWrAyMgptI/VPulEIBmgY/QhahREUj5oMQ2Lejy
   y8M2tOP5ZEvhHh3wUazp2NGNnHeEu8GXxs770j62dkEa414KMdypUaGnN
   WXvA6dDHIjUoHDzzlEpcVJy55CBHf8Em6HIN5SDod6isMUevkTZlkOBUS
   g==;
X-CSE-ConnectionGUID: 3KHBOYHQSVS7Taj8LaJpuw==
X-CSE-MsgGUID: COk5aPteR9CJtdXBSmLuRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89245501"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89245501"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:00:06 -0700
X-CSE-ConnectionGUID: rA4vbMPiSeqlTdTUB0VjHQ==
X-CSE-MsgGUID: m+qSDraaTlqZsJdcGze2+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="231455792"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:00:03 -0700
Date: Wed, 6 May 2026 13:59:59 +0800
From: "Lai, Yi" <yi1.lai@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net] ipmr: Free mr_table after RCU grace period.
Message-ID: <afrY34dLXNUboevf@ly-workstation>
References: <20260423053456.4097409-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423053456.4097409-1-kuniyu@google.com>
X-Rspamd-Queue-Id: 270F74D66BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284708-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi1.lai@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.com:url,localhost:email,start3.sh:url]

On Thu, Apr 23, 2026 at 05:34:54AM +0000, Kuniyuki Iwashima wrote:
> With CONFIG_IP_MROUTE_MULTIPLE_TABLES=n, ipmr_fib_lookup()
> does not check if net->ipv4.mrt is NULL.
> 
> Since default_device_exit_batch() is called after ->exit_rtnl(),
> a device could receive IGMP packets and access net->ipv4.mrt
> during/after ipmr_rules_exit_rtnl().
> 
> If ipmr_rules_exit_rtnl() had already cleared it and freed the
> memory, the access would trigger null-ptr-deref or use-after-free.
> 
> Let's fix it by using RCU helper and free mrt after RCU grace
> period.
> 
> In addition, check_net(net) is added to mroute_clean_tables()
> and ipmr_cache_unresolved() to synchronise via mfc_unres_lock.
> This prevents ipmr_cache_unresolved() from putting skb into
> c->_c.mfc_un.unres.unresolved after mroute_clean_tables()
> purges it.
> 
> For the same reason, timer_shutdown_sync() is moved after
> mroute_clean_tables().
> 
> Since rhltable_destroy() holds mutex internally, rcu_work is
> used, and it is placed as the first member because rcu_head
> must be placed within <4K offset.  mr_table is alraedy 3864
> bytes without rcu_work.
> 
> Note that IP6MR is not yet converted to ->exit_rtnl(), so this
> change is not needed for now but will be.
> 
> Fixes: b22b01867406 ("ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Hi Kuniyuki Iwashima,

Greetings!

I used Syzkaller and found that there is WARNING: suspicious RCU usage in reg_vif_xmit in linux-next next-20260505.

After bisection and the first bad commit is:
"
b3b6babf4751 ipmr: Free mr_table after RCU grace period
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_vif_xmit
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_vif_xmit/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_vif_xmit/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_vif_xmit/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_vif_xmit/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/260506_091248_reg_vif_xmit/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260506_091248_reg_vif_xmit/bzImage_next-20260505
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/260506_091248_reg_vif_xmit/next-20260505_dmesg.log

"
[   18.611146] =============================
[   18.611406] WARNING: suspicious RCU usage
[   18.611657] 7.1.0-rc2-next-20260505-next-2026050 #1 Not tainted
[   18.612022] -----------------------------
[   18.612289] net/ipv4/ipmr.c:329 suspicious rcu_dereference_check() usage!
[   18.612755]
[   18.612755] other info that might help us debug this:
[   18.612755]
[   18.613314]
[   18.613314] rcu_scheduler_active = 2, debug_locks = 1
[   18.613758] 2 locks held by repro/725:
[   18.614195]  #0: ffffffff87896440 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x239/0x4140
[   18.614860]  #1: ff1100000df5b918 (_xmit_PIMREG#2){+...}-{3:3}, at: __dev_queue_xmit+0x1d5d/0x4140
[   18.615505]
[   18.615505] stack backtrace:
[   18.615814] CPU: 0 UID: 0 PID: 725 Comm: repro Not tainted 7.1.0-rc2-next-20260505-next-2026050 #1 PREEMPT(lazy)
[   18.615826] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu4
[   18.615831] Call Trace:
[   18.615834]  <TASK>
[   18.615838]  dump_stack_lvl+0x121/0x150
[   18.615853]  dump_stack+0x19/0x20
[   18.615864]  lockdep_rcu_suspicious+0x15b/0x1f0
[   18.615882]  reg_vif_xmit+0x2ee/0x3c0
[   18.615898]  dev_hard_start_xmit+0x170/0x700
[   18.615915]  __dev_queue_xmit+0x1df1/0x4140
[   18.615931]  ? __might_fault+0x14a/0x1b0
[   18.615943]  ? __this_cpu_preempt_check+0x21/0x30
[   18.615961]  ? __pfx___dev_queue_xmit+0x10/0x10
[   18.615977]  ? _copy_from_iter+0x288/0x15e0
[   18.615989]  ? __virt_addr_valid+0x22c/0x420
[   18.616004]  ? __virt_addr_valid+0x22c/0x420
[   18.616018]  ? __this_cpu_preempt_check+0x21/0x30
[   18.616030]  ? __pfx__copy_from_iter+0x10/0x10
[   18.616048]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   18.616064]  ? packet_parse_headers+0x439/0x7b0
[   18.616076]  ? packet_parse_headers+0x202/0x7b0
[   18.616088]  ? __pfx_packet_parse_headers+0x10/0x10
[   18.616103]  packet_xmit+0x252/0x370
[   18.616119]  packet_sendmsg+0x39ad/0x5650
[   18.616136]  ? __lock_acquire+0x412/0x2390
[   18.616174]  ? __pfx_packet_sendmsg+0x10/0x10
[   18.616189]  ? audit_watch_handle_event+0x130/0x900
[   18.616201]  ? __import_iovec+0x1df/0x660
[   18.616213]  ? _copy_from_user+0x75/0xa0
[   18.616229]  ? __pfx_packet_sendmsg+0x10/0x10
[   18.616242]  ____sys_sendmsg+0xa21/0xba0
[   18.616257]  ? __pfx_____sys_sendmsg+0x10/0x10
[   18.616274]  ? __this_cpu_preempt_check+0x21/0x30
[   18.616285]  ? lock_release+0x14f/0x2c0
[   18.616305]  ___sys_sendmsg+0x121/0x1c0
[   18.616322]  ? __pfx____sys_sendmsg+0x10/0x10
[   18.616347]  ? __handle_mm_fault+0x656/0x2cb0
[   18.616388]  __sys_sendmsg+0x177/0x220
[   18.616403]  ? __pfx___sys_sendmsg+0x10/0x10
[   18.616428]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   18.616440]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   18.616453]  ? ktime_get_coarse_real_ts64+0xad/0xf0
[   18.616471]  __x64_sys_sendmsg+0x80/0xc0
[   18.616487]  x64_sys_call+0x1d9c/0x21c0
[   18.616499]  do_syscall_64+0xc1/0x1020
[   18.616517]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.616527] RIP: 0033:0x7f93b863ee5d
[   18.616536] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c8
[   18.616546] RSP: 002b:00007fff211cf048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   18.616555] RAX: ffffffffffffffda RBX: 0000200000000380 RCX: 00007f93b863ee5d
[   18.616561] RDX: 0000000000000000 RSI: 00002000000012c0 RDI: 0000000000000004
[   18.616567] RBP: 00007fff211cf070 R08: 0000000200000000 R09: 0000000200000000
[   18.616573] R10: 0000000200000000 R11: 0000000000000246 R12: 00007fff211cf188
[   18.616579] R13: 0000000000401164 R14: 0000000000403e08 R15: 00007f93b886e000
[   18.616601]  </TASK>
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

> ---
>  include/linux/mroute_base.h |   3 +
>  net/ipv4/ipmr.c             | 108 +++++++++++++++++++-----------------
>  net/ipv4/ipmr_base.c        |  16 ++++++
>  3 files changed, 77 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> index cf3374580f74..5d75cc5b057e 100644
> --- a/include/linux/mroute_base.h
> +++ b/include/linux/mroute_base.h
> @@ -226,6 +226,7 @@ struct mr_table_ops {
>  
>  /**
>   * struct mr_table - a multicast routing table
> + * @work: used for table destruction
>   * @list: entry within a list of multicast routing tables
>   * @net: net where this table belongs
>   * @ops: protocol specific operations
> @@ -243,6 +244,7 @@ struct mr_table_ops {
>   * @mroute_reg_vif_num: PIM-device vif index
>   */
>  struct mr_table {
> +	struct rcu_work		work;
>  	struct list_head	list;
>  	possible_net_t		net;
>  	struct mr_table_ops	ops;
> @@ -274,6 +276,7 @@ void vif_device_init(struct vif_device *v,
>  		     unsigned short flags,
>  		     unsigned short get_iflink_mask);
>  
> +void mr_table_free(struct mr_table *mrt);
>  struct mr_table *
>  mr_table_alloc(struct net *net, u32 id,
>  	       struct mr_table_ops *ops,
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 8a08d09b4c30..2058ca860294 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -151,16 +151,6 @@ static struct mr_table *__ipmr_get_table(struct net *net, u32 id)
>  	return NULL;
>  }
>  
> -static struct mr_table *ipmr_get_table(struct net *net, u32 id)
> -{
> -	struct mr_table *mrt;
> -
> -	rcu_read_lock();
> -	mrt = __ipmr_get_table(net, id);
> -	rcu_read_unlock();
> -	return mrt;
> -}
> -
>  static int ipmr_fib_lookup(struct net *net, struct flowi4 *flp4,
>  			   struct mr_table **mrt)
>  {
> @@ -293,7 +283,7 @@ static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
>  	struct mr_table *mrt, *next;
>  
>  	list_for_each_entry_safe(mrt, next, &net->ipv4.mr_tables, list) {
> -		list_del(&mrt->list);
> +		list_del_rcu(&mrt->list);
>  		ipmr_free_table(mrt, dev_kill_list);
>  	}
>  }
> @@ -315,28 +305,30 @@ bool ipmr_rule_default(const struct fib_rule *rule)
>  }
>  EXPORT_SYMBOL(ipmr_rule_default);
>  #else
> -#define ipmr_for_each_table(mrt, net) \
> -	for (mrt = net->ipv4.mrt; mrt; mrt = NULL)
> -
>  static struct mr_table *ipmr_mr_table_iter(struct net *net,
>  					   struct mr_table *mrt)
>  {
>  	if (!mrt)
> -		return net->ipv4.mrt;
> +		return rcu_dereference(net->ipv4.mrt);
>  	return NULL;
>  }
>  
> -static struct mr_table *ipmr_get_table(struct net *net, u32 id)
> +static struct mr_table *__ipmr_get_table(struct net *net, u32 id)
>  {
> -	return net->ipv4.mrt;
> +	return rcu_dereference_check(net->ipv4.mrt,
> +				     lockdep_rtnl_is_held() ||
> +				     !rcu_access_pointer(net->ipv4.mrt));
>  }
>  
> -#define __ipmr_get_table ipmr_get_table
> +#define ipmr_for_each_table(mrt, net)				\
> +	for (mrt = __ipmr_get_table(net, 0); mrt; mrt = NULL)
>  
>  static int ipmr_fib_lookup(struct net *net, struct flowi4 *flp4,
>  			   struct mr_table **mrt)
>  {
> -	*mrt = net->ipv4.mrt;
> +	*mrt = rcu_dereference(net->ipv4.mrt);
> +	if (!*mrt)
> +		return -EAGAIN;
>  	return 0;
>  }
>  
> @@ -347,7 +339,8 @@ static int __net_init ipmr_rules_init(struct net *net)
>  	mrt = ipmr_new_table(net, RT_TABLE_DEFAULT);
>  	if (IS_ERR(mrt))
>  		return PTR_ERR(mrt);
> -	net->ipv4.mrt = mrt;
> +
> +	rcu_assign_pointer(net->ipv4.mrt, mrt);
>  	return 0;
>  }
>  
> @@ -358,9 +351,10 @@ static void __net_exit ipmr_rules_exit(struct net *net)
>  static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
>  					    struct list_head *dev_kill_list)
>  {
> -	ipmr_free_table(net->ipv4.mrt, dev_kill_list);
> +	struct mr_table *mrt = rcu_dereference_protected(net->ipv4.mrt, 1);
>  
> -	net->ipv4.mrt = NULL;
> +	RCU_INIT_POINTER(net->ipv4.mrt, NULL);
> +	ipmr_free_table(mrt, dev_kill_list);
>  }
>  
>  static int ipmr_rules_dump(struct net *net, struct notifier_block *nb,
> @@ -381,6 +375,17 @@ bool ipmr_rule_default(const struct fib_rule *rule)
>  EXPORT_SYMBOL(ipmr_rule_default);
>  #endif
>  
> +static struct mr_table *ipmr_get_table(struct net *net, u32 id)
> +{
> +	struct mr_table *mrt;
> +
> +	rcu_read_lock();
> +	mrt = __ipmr_get_table(net, id);
> +	rcu_read_unlock();
> +
> +	return mrt;
> +}
> +
>  static inline int ipmr_hash_cmp(struct rhashtable_compare_arg *arg,
>  				const void *ptr)
>  {
> @@ -441,12 +446,11 @@ static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_lis
>  
>  	WARN_ON_ONCE(!mr_can_free_table(net));
>  
> -	timer_shutdown_sync(&mrt->ipmr_expire_timer);
>  	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
>  			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
>  			    &ipmr_dev_kill_list);
> -	rhltable_destroy(&mrt->mfc_hash);
> -	kfree(mrt);
> +	timer_shutdown_sync(&mrt->ipmr_expire_timer);
> +	mr_table_free(mrt);
>  
>  	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ipmr_dev_kill_list));
>  	list_splice(&ipmr_dev_kill_list, dev_kill_list);
> @@ -1135,12 +1139,19 @@ static int ipmr_cache_report(const struct mr_table *mrt,
>  static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  				 struct sk_buff *skb, struct net_device *dev)
>  {
> +	struct net *net = read_pnet(&mrt->net);
>  	const struct iphdr *iph = ip_hdr(skb);
> -	struct mfc_cache *c;
> +	struct mfc_cache *c = NULL;
>  	bool found = false;
>  	int err;
>  
>  	spin_lock_bh(&mfc_unres_lock);
> +
> +	if (!check_net(net)) {
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
>  	list_for_each_entry(c, &mrt->mfc_unres_queue, _c.list) {
>  		if (c->mfc_mcastgrp == iph->daddr &&
>  		    c->mfc_origin == iph->saddr) {
> @@ -1153,10 +1164,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  		/* Create a new entry if allowable */
>  		c = ipmr_cache_alloc_unres();
>  		if (!c) {
> -			spin_unlock_bh(&mfc_unres_lock);
> -
> -			kfree_skb(skb);
> -			return -ENOBUFS;
> +			err = -ENOBUFS;
> +			goto err;
>  		}
>  
>  		/* Fill in the new cache entry */
> @@ -1166,17 +1175,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  
>  		/* Reflect first query at mrouted. */
>  		err = ipmr_cache_report(mrt, skb, vifi, IGMPMSG_NOCACHE);
> -
> -		if (err < 0) {
> -			/* If the report failed throw the cache entry
> -			   out - Brad Parker
> -			 */
> -			spin_unlock_bh(&mfc_unres_lock);
> -
> -			ipmr_cache_free(c);
> -			kfree_skb(skb);
> -			return err;
> -		}
> +		if (err < 0)
> +			goto err;
>  
>  		atomic_inc(&mrt->cache_resolve_queue_len);
>  		list_add(&c->_c.list, &mrt->mfc_unres_queue);
> @@ -1189,18 +1189,26 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  
>  	/* See if we can append the packet */
>  	if (c->_c.mfc_un.unres.unresolved.qlen > 3) {
> -		kfree_skb(skb);
> +		c = NULL;
>  		err = -ENOBUFS;
> -	} else {
> -		if (dev) {
> -			skb->dev = dev;
> -			skb->skb_iif = dev->ifindex;
> -		}
> -		skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
> -		err = 0;
> +		goto err;
> +	}
> +
> +	if (dev) {
> +		skb->dev = dev;
> +		skb->skb_iif = dev->ifindex;
>  	}
>  
> +	skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
> +
>  	spin_unlock_bh(&mfc_unres_lock);
> +	return 0;
> +
> +err:
> +	spin_unlock_bh(&mfc_unres_lock);
> +	if (c)
> +		ipmr_cache_free(c);
> +	kfree_skb(skb);
>  	return err;
>  }
>  
> @@ -1346,7 +1354,7 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
>  	}
>  
>  	if (flags & MRT_FLUSH_MFC) {
> -		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> +		if (atomic_read(&mrt->cache_resolve_queue_len) != 0 || !check_net(net)) {
>  			spin_lock_bh(&mfc_unres_lock);
>  			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
>  				list_del(&c->list);
> diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
> index 37a3c144276c..3930d612c3de 100644
> --- a/net/ipv4/ipmr_base.c
> +++ b/net/ipv4/ipmr_base.c
> @@ -28,6 +28,20 @@ void vif_device_init(struct vif_device *v,
>  		v->link = dev->ifindex;
>  }
>  
> +static void __mr_free_table(struct work_struct *work)
> +{
> +	struct mr_table *mrt = container_of(to_rcu_work(work),
> +					    struct mr_table, work);
> +
> +	rhltable_destroy(&mrt->mfc_hash);
> +	kfree(mrt);
> +}
> +
> +void mr_table_free(struct mr_table *mrt)
> +{
> +	queue_rcu_work(system_unbound_wq, &mrt->work);
> +}
> +
>  struct mr_table *
>  mr_table_alloc(struct net *net, u32 id,
>  	       struct mr_table_ops *ops,
> @@ -50,6 +64,8 @@ mr_table_alloc(struct net *net, u32 id,
>  		kfree(mrt);
>  		return ERR_PTR(err);
>  	}
> +
> +	INIT_RCU_WORK(&mrt->work, __mr_free_table);
>  	INIT_LIST_HEAD(&mrt->mfc_cache_list);
>  	INIT_LIST_HEAD(&mrt->mfc_unres_queue);
>  
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 

