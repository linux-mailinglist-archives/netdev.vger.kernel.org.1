Return-Path: <netdev+bounces-148687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEC9E2DC7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2312283F29
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F8204F89;
	Tue,  3 Dec 2024 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbyjpCKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D931F8EEE
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259882; cv=none; b=FlCpx69jmFZnxS4Ve4asDZ78171U39Zmxggnr/Cb6fVROCopNGjFuObdFa4wB9YAV+OT3GvYNcTNGOgGGBD+55GnldryEiD6CFwEmxK8CAHiOeydU3izdT95kt/tIGVTq7lEX9cTzE3XzADOxGfNnQuqxm8KYX+G9RF3N27qnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259882; c=relaxed/simple;
	bh=lLfpM5IQp0sLN1LefPgAqi0BMzlhxMBc+0TNHa//RjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnE1sN8r1B3IjthMIuhg1dkeBIuC7IHQF+4AHGPu4Ri8tYA0UW2RxlSqW9k0pPupK4CxPknt9HIDrp9N/4UKA5/1/na9bbv5EIh6I1OCJZ8N2q8huLI3lmm6oRUI2mnb3nQmg63J3tGRB7+4ZVkgJ7b7WmLqO0rVAiP9o/1B2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbyjpCKM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215c54e5f24so10383105ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 13:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259880; x=1733864680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwI5fO24DTdfvyVV7IW8y+H37bG2nklnndbeMk0xhXY=;
        b=nbyjpCKM/LlOO4FDo+KtO+D7W1KVgfux2eRkgBOTMeJjj6CitpWL+7hZLPnCV3Tzen
         Y7awn2jYfxdv+ulFVunbYOQTv5oDCjiXmo7ovI7tYqdRaoapGF1S/4DW6QNs+s762z3n
         /eJpAl4tZPGYiaGjlJ7yS+NitJuIAkHaOf6534m1J9g8/UDWbnQGupNpiIrhVXci0EWH
         Yy6sD+by1yZGLKYGNhe60GyV4Ng4MBBh7R5GBVJH5I4CM7Yq1qBEaBSX0JGqMwp/h6hf
         HToxjbk7IT3hiV8J1jYYvXftCkAjGqwj44Fdrww+iY251/p+2Ddrsg1gsDVpzJTHasFC
         hTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259880; x=1733864680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwI5fO24DTdfvyVV7IW8y+H37bG2nklnndbeMk0xhXY=;
        b=IIl+RlsQb+nJrNPZ7aUgHBn2+n21ZV8HWwAqW7X782PAFqeUNxY0GS3hEa2ifjtPH4
         T126XjdoXsOHdwSjrot3pEBEnuSBZjWvLliypoZA30mt/yAui/cp6NK+0NbMpEij+SCH
         y2SsS+pptIS+OXVqV/VDP//FJIowEaBcT1IbtJa4HZSTzLZgXcD73+6r/hh1nYUEWlGz
         /tIWl0HT8JPIgnO91gSyvNFrD+St//22/HtgZmTvqvCxid/j23RMf0yPmNM19mGvIODd
         bky9MmZWKAkN3KLSnwOFN0zVj93ON1taR7rA21q/OFJJGU3Wmw8Q59zt4rDZ7ujXAqeF
         U47A==
X-Forwarded-Encrypted: i=1; AJvYcCX1kYYCbQMBz8tXzXqT5UAU0kT3+qeTwcE/8GbMW2d8s/oQj/PuvJShSGN97pQtNU9/MiuzYJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/DTCE1c+X8rgHXcnSMG6T8qYYscyqux4VJIHQLsEn3pKcsKm
	9tMa/CQ/zb4X3fKWkVHq8lUTgAc+zlt+YSbdTcEQSKosyzz9rLM00ppM9KU=
X-Gm-Gg: ASbGnctxfQiXv9DjTkFiNxaHKQjgT/hR2yaGdQm2a7dQ1w876QCPA9XfGbBC26R+Mbv
	VWhLoB9+Wm8wvraHmIA+vUbKPSyxOoBjRDXKC+W6+YJmRIpd7XwHgsT/DY8GcpkW/vWfSLLbfUt
	ABtbSktULmrkRmGuhNgANZImG/EzGZW9tuzp1vyc7jweW3LWZtGRJOR43E3mLRoWNkyfQ1+R1LK
	oilVqiMIjWQp52Gn8vb2IqxvrTGriwSPZ1DcwzbvnSMDABuSg==
X-Google-Smtp-Source: AGHT+IHiMtqDxIuX6AD2frTdncXVaVc9RdoZJGdmhnSoZ1dLtmFDyU/280mc8OBp57cJSFAnrXgIaQ==
X-Received: by 2002:a17:902:e743:b0:215:4a4e:9286 with SMTP id d9443c01a7336-215bd0e66b0mr59232805ad.26.1733259879291;
        Tue, 03 Dec 2024 13:04:39 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219cd615sm98867295ad.269.2024.12.03.13.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:04:38 -0800 (PST)
Date: Tue, 3 Dec 2024 13:04:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Dan Streetman <dan.streetman@canonical.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] net: defer final 'struct net' free in netns dismantle
Message-ID: <Z09yZqv82dQn-1zI@mini-arch>
References: <20241203165045.2428360-1-edumazet@google.com>
 <53482ace-71a3-4fa3-a7d3-592311fc3c1b@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53482ace-71a3-4fa3-a7d3-592311fc3c1b@ovn.org>

On 12/03, Ilya Maximets wrote:
> On 12/3/24 17:50, Eric Dumazet wrote:
> > Ilya reported a slab-use-after-free in dst_destroy [1]
> > 
> > Issue is in xfrm6_net_init() and xfrm4_net_init() :
> > 
> > They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
> > 
> > But net structure might be freed before all the dst callbacks are
> > called. So when dst_destroy() calls later :
> > 
> > if (dst->ops->destroy)
> >     dst->ops->destroy(dst);
> > 
> > dst->ops points to the old net->xfrm.xfrm[46]_dst_ops, which has been freed.
> > 
> > See a relevant issue fixed in :
> > 
> > ac888d58869b ("net: do not delay dst_entries_add() in dst_release()")
> > 
> > A fix is to queue the 'struct net' to be freed after one
> > another cleanup_net() round (and existing rcu_barrier())
> > 
> > [1]
> 
> <snip>
> 
> Hi, Eric.  Thanks for the patch!
> 
> Though I tried to test it by applying directly on top of v6.12 tag, but I got
> the following UAF shortly after booting the kernel.  Seems like podman service
> was initializing something and creating namespaces for that.
> 
> I can try applying the change on top of net tree, if that helps.
> 
> Best regards, Ilya Maximets.
> 
> The log:
> 
> Dec  3 13:12:09  systemd-logind[1240]: New session 3 of user root.
> Dec  3 13:12:09  systemd[1]: Started Session 3 of User root.
> Dec  3 13:12:39  systemd[1]: systemd-hostnamed.service: Deactivated successfully.
> Dec  3 13:12:40  kernel: ==================================================================
> Dec  3 13:12:40  kernel: BUG: KASAN: slab-use-after-free in cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
> Dec  3 13:12:40  kernel: Read of size 8 at addr ffff888166941bf8 by task kworker/u160:1/13
> Dec  3 13:12:40  kernel:
> Dec  3 13:12:40  kernel: CPU: 34 UID: 0 PID: 13 Comm: kworker/u160:1 Not tainted 6.12.0+ #69
> Dec  3 13:12:40  kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el9 04/01/2014
> Dec  3 13:12:40  kernel: Workqueue: netns cleanup_net
> Dec  3 13:12:40  kernel: Call Trace:
> Dec  3 13:12:40  kernel: <TASK>
> Dec  3 13:12:40  kernel: dump_stack_lvl (lib/dump_stack.c:124) 
> Dec  3 13:12:40  kernel: print_address_description.constprop.0 (mm/kasan/report.c:378) 
> Dec  3 13:12:40  kernel: ? cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
> Dec  3 13:12:40  kernel: print_report (mm/kasan/report.c:489) 
> Dec  3 13:12:40  kernel: ? cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
> Dec  3 13:12:40  kernel: ? kasan_addr_to_slab (mm/kasan/common.c:37) 
> Dec  3 13:12:40  kernel: kasan_report (mm/kasan/report.c:603) 
> Dec  3 13:12:40  kernel: ? cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
> Dec  3 13:12:40  kernel: cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
> Dec  3 13:12:40  kernel: ? __pfx_lock_acquire (kernel/locking/lockdep.c:5793) 
> Dec  3 13:12:40  kernel: ? __pfx_cleanup_net (net/core/net_namespace.c:586) 
> Dec  3 13:12:40  kernel: ? lock_is_held_type (kernel/locking/lockdep.c:5566 kernel/locking/lockdep.c:5897) 
> Dec  3 13:12:40  kernel: process_one_work (kernel/workqueue.c:3229) 
> Dec  3 13:12:40  kernel: ? __pfx_lock_acquire (kernel/locking/lockdep.c:5793) 
> Dec  3 13:12:40  kernel: ? __pfx_process_one_work (kernel/workqueue.c:3131) 
> Dec  3 13:12:40  kernel: ? assign_work (kernel/workqueue.c:1200) 
> Dec  3 13:12:40  kernel: ? lock_is_held_type (kernel/locking/lockdep.c:5566 kernel/locking/lockdep.c:5897) 
> Dec  3 13:12:40  kernel: worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391) 
> Dec  3 13:12:40  kernel: ? __kthread_parkme (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
> Dec  3 13:12:40  kernel: ? __pfx_worker_thread (kernel/workqueue.c:3337) 
> Dec  3 13:12:40  kernel: kthread (kernel/kthread.c:389) 
> Dec  3 13:12:40  kernel: ? __pfx_kthread (kernel/kthread.c:342) 
> Dec  3 13:12:40  kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
> Dec  3 13:12:40  kernel: ? __pfx_kthread (kernel/kthread.c:342) 
> Dec  3 13:12:40  kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> Dec  3 13:12:40  kernel: </TASK>
> Dec  3 13:12:40  kernel:
> Dec  3 13:12:40  kernel: Allocated by task 1250:
> Dec  3 13:12:40  kernel: kasan_save_stack (mm/kasan/common.c:48) 
> Dec  3 13:12:40  kernel: kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
> Dec  3 13:12:40  kernel: __kasan_slab_alloc (mm/kasan/common.c:319 mm/kasan/common.c:345) 
> Dec  3 13:12:40  kernel: kmem_cache_alloc_noprof (mm/slub.c:4085 mm/slub.c:4134 mm/slub.c:4141) 
> Dec  3 13:12:40  kernel: copy_net_ns (net/core/net_namespace.c:421 net/core/net_namespace.c:496) 
> Dec  3 13:12:40  kernel: create_new_namespaces (kernel/nsproxy.c:110) 
> Dec  3 13:12:40  kernel: unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4)) 
> Dec  3 13:12:40  kernel: ksys_unshare (kernel/fork.c:3313) 
> Dec  3 13:12:40  kernel: __x64_sys_unshare (kernel/fork.c:3382) 
> Dec  3 13:12:40  kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
> Dec  3 13:12:40  kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> Dec  3 13:12:40  kernel:
> Dec  3 13:12:40  kernel: Freed by task 13:
> Dec  3 13:12:40  kernel: kasan_save_stack (mm/kasan/common.c:48) 
> Dec  3 13:12:40  kernel: kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
> Dec  3 13:12:40  kernel: kasan_save_free_info (mm/kasan/generic.c:582) 
> Dec  3 13:12:40  kernel: __kasan_slab_free (mm/kasan/common.c:271) 
> Dec  3 13:12:40  kernel: kmem_cache_free (mm/slub.c:4579 mm/slub.c:4681) 
> Dec  3 13:12:40  kernel: cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
> Dec  3 13:12:40  kernel: process_one_work (kernel/workqueue.c:3229) 
> Dec  3 13:12:40  kernel: worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391) 
> Dec  3 13:12:40  kernel: kthread (kernel/kthread.c:389) 
> Dec  3 13:12:40  kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
> Dec  3 13:12:40  kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> Dec  3 13:12:40  kernel:
> Dec  3 13:12:40  kernel: The buggy address belongs to the object at ffff888166941b40#012 which belongs to the cache net_namespace of size 6720
> Dec  3 13:12:40  kernel: The buggy address is located 184 bytes inside of#012 freed 6720-byte region [ffff888166941b40, ffff888166943580)
> Dec  3 13:12:40  kernel:
> Dec  3 13:12:40  kernel: The buggy address belongs to the physical page:
> Dec  3 13:12:40  kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x166940
> Dec  3 13:12:40  kernel: head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> Dec  3 13:12:40  kernel: memcg:ffff8881229685c1
> Dec  3 13:12:40  kernel: flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> Dec  3 13:12:40  kernel: page_type: f5(slab)
> Dec  3 13:12:40  kernel: raw: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
> Dec  3 13:12:40  kernel: raw: 0000000000000000 0000000080040004 00000001f5000000 ffff8881229685c1
> Dec  3 13:12:40  kernel: head: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
> Dec  3 13:12:40  kernel: head: 0000000000000000 0000000080040004 00000001f5000000 ffff8881229685c1
> Dec  3 13:12:40  kernel: head: 0017ffffc0000003 ffffea00059a5001 ffffffffffffffff 0000000000000000
> Dec  3 13:12:40  kernel: head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> Dec  3 13:12:40  kernel: page dumped because: kasan: bad access detected
> Dec  3 13:12:40  kernel:
> Dec  3 13:12:40  kernel: Memory state around the buggy address:
> Dec  3 13:12:40  kernel: ffff888166941a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> Dec  3 13:12:40  kernel: ffff888166941b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> Dec  3 13:12:40  kernel: >ffff888166941b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Dec  3 13:12:40  kernel:                                                                ^
> Dec  3 13:12:40  kernel: ffff888166941c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Dec  3 13:12:40  kernel: ffff888166941c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Dec  3 13:12:40  kernel: ==================================================================
> Dec  3 13:12:40  kernel: Disabling lock debugging due to kernel taint
> Dec  3 13:14:14  systemd[1]: var-lib-containers-storage-overlay-compat1591001862-merged.mount: Deactivated successfully.
> Dec  3 13:14:14  kernel: evm: overlay not supported
> Dec  3 13:14:14  systemd[1]: var-lib-containers-storage-overlay-metacopyx2dcheck2012509683-merged.mount: Deactivated successfully.
> Dec  3 13:14:14  podman[5241]: 2024-12-03 13:14:14.444912997 -0500 EST m=+0.123882461 system refresh
> Dec  3 13:14:15  systemd[1]: var-lib-containers-storage-overlay.mount: Deactivated successfully.

Let's also kick it out from the NIPA queue:

---
pw-bot: cr

