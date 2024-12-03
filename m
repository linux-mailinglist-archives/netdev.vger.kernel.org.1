Return-Path: <netdev+bounces-148629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E4F9E2D6F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CAB0B27FFC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9EA1FAC54;
	Tue,  3 Dec 2024 18:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E81E868
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250187; cv=none; b=M7bO0sy0G2IEKxVBy54uXs30IBG+ClpE3Ji62dSWStZ7Qi3YrSxl+dVuFpYDrcseETRBIgeItb4MEJbm8x3ZgOypl1HYGe6KFWWi9f0UKY+yWFcFqR0UzaBI30MwKpNw+HB9/m20zNqVd1WjW/NvzOgSY2eTVYBUND0zJXeopyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250187; c=relaxed/simple;
	bh=XWTpv9XIvp3Gs7DHEMACAPKt6ybjU0L4J1H5rcRJOkM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NnPl/uyYl9u31Z/bk9PxMH0zNB4wlEe9CFp39osMRJTFTvRfNd0lA1yi9NlCJVKxM501ypgMjHGarx7DHZztsdFxnnBYhfYrHp/bpH1ybBJTcp+vsRBsnKwTcclfZMEQvS58tx5wWxQe9ELgIfecKNa7Wr2DPDSjzFbPVrPdC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so86732251fa.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 10:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250183; x=1733854983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOV6CAkadMa+sMSYQfJNz9BzXWLgU0k8H+xTz5G/WI8=;
        b=f5bcYs0BXNeAafqGyV29Zf3r41Z3kTC5gh3NWt9yqCr2mFo7HJcxtoq6dW3K6Rx6oc
         MsnltyA4gfUejcOCUG/Ipmqag990sYePUJnd1/HxmmQCHqZHPL9XpVkwhCp1HaYaxJ69
         4IHbu8iRGJHtgyI7G5snBSI6yoqyYNwPDOFVJbvPfHOnyvElfz/xO5OO8gKnPsu/fU7k
         D8oUCU4XMVfqITNBTBLeJTIl/otDpTn4b2nEqi6zejCdageeqPq7VSXfbxVpwhBawu6V
         zjRFpoI6Q1o8bC77amXDJ1NvYWxujvM1+eqOnPuCHgIY+pqWzn0vvJlfdt+as9J+WEj4
         DaHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdruj3iBaxtgsNcmawpkY2Ich9pexrM1JVSKrMLT7tXU/uwxVv9TyQqjBemYcTbbWy1sWsdi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeYecIIZuxXrlHvsTIUBRo/xbz7JrYFydZYuWeNH9u8n4EqLN
	FncuqaECHcJo2IC4OfmMmlWON7N4EyHaXuohl3wyhd9nWkZzwYg7
X-Gm-Gg: ASbGncsrriCfYTIh+sPKtCP2MqRRffxxy6IXrkeLuSVsbCZSlRj6LtSLwJYt8hmYLOz
	wEeyb/cC+BFsCU0TM85M4T3XgKHmCi7en1UyF+rRlxkQFn/tK/6VAycKjL15jwUwRSxXBS5XlFH
	zyP28elup+nh9eRlOQmUSb+GPlz3psmmv48UJXnQLA+H+c0bz8vJIrIzwXKvRab5GZjMvSL9jaR
	SjgUb3742Di2Ekuo7WcbggGBTjFTsO8P/xpqPE8VvOixGLJFQzjDSthQtyz0u8kZ3sij1u4eB3Z
	7FnXQA==
X-Google-Smtp-Source: AGHT+IFmMCiva/qCKcyQK6S38XpudT60WJ+KcAtUpPa517Z+wlNUpTNJUousEnL5qrYsgB6ppfyfFw==
X-Received: by 2002:a05:651c:210e:b0:2ff:78be:e030 with SMTP id 38308e7fff4ca-30009c46428mr36573951fa.3.1733250183057;
        Tue, 03 Dec 2024 10:23:03 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599953e4csm650631966b.186.2024.12.03.10.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 10:23:02 -0800 (PST)
Message-ID: <53482ace-71a3-4fa3-a7d3-592311fc3c1b@ovn.org>
Date: Tue, 3 Dec 2024 19:23:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Dan Streetman <dan.streetman@canonical.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] net: defer final 'struct net' free in netns dismantle
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20241203165045.2428360-1-edumazet@google.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20241203165045.2428360-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 17:50, Eric Dumazet wrote:
> Ilya reported a slab-use-after-free in dst_destroy [1]
> 
> Issue is in xfrm6_net_init() and xfrm4_net_init() :
> 
> They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
> 
> But net structure might be freed before all the dst callbacks are
> called. So when dst_destroy() calls later :
> 
> if (dst->ops->destroy)
>     dst->ops->destroy(dst);
> 
> dst->ops points to the old net->xfrm.xfrm[46]_dst_ops, which has been freed.
> 
> See a relevant issue fixed in :
> 
> ac888d58869b ("net: do not delay dst_entries_add() in dst_release()")
> 
> A fix is to queue the 'struct net' to be freed after one
> another cleanup_net() round (and existing rcu_barrier())
> 
> [1]

<snip>

Hi, Eric.  Thanks for the patch!

Though I tried to test it by applying directly on top of v6.12 tag, but I got
the following UAF shortly after booting the kernel.  Seems like podman service
was initializing something and creating namespaces for that.

I can try applying the change on top of net tree, if that helps.

Best regards, Ilya Maximets.

The log:

Dec  3 13:12:09  systemd-logind[1240]: New session 3 of user root.
Dec  3 13:12:09  systemd[1]: Started Session 3 of User root.
Dec  3 13:12:39  systemd[1]: systemd-hostnamed.service: Deactivated successfully.
Dec  3 13:12:40  kernel: ==================================================================
Dec  3 13:12:40  kernel: BUG: KASAN: slab-use-after-free in cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
Dec  3 13:12:40  kernel: Read of size 8 at addr ffff888166941bf8 by task kworker/u160:1/13
Dec  3 13:12:40  kernel:
Dec  3 13:12:40  kernel: CPU: 34 UID: 0 PID: 13 Comm: kworker/u160:1 Not tainted 6.12.0+ #69
Dec  3 13:12:40  kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el9 04/01/2014
Dec  3 13:12:40  kernel: Workqueue: netns cleanup_net
Dec  3 13:12:40  kernel: Call Trace:
Dec  3 13:12:40  kernel: <TASK>
Dec  3 13:12:40  kernel: dump_stack_lvl (lib/dump_stack.c:124) 
Dec  3 13:12:40  kernel: print_address_description.constprop.0 (mm/kasan/report.c:378) 
Dec  3 13:12:40  kernel: ? cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
Dec  3 13:12:40  kernel: print_report (mm/kasan/report.c:489) 
Dec  3 13:12:40  kernel: ? cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
Dec  3 13:12:40  kernel: ? kasan_addr_to_slab (mm/kasan/common.c:37) 
Dec  3 13:12:40  kernel: kasan_report (mm/kasan/report.c:603) 
Dec  3 13:12:40  kernel: ? cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
Dec  3 13:12:40  kernel: cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
Dec  3 13:12:40  kernel: ? __pfx_lock_acquire (kernel/locking/lockdep.c:5793) 
Dec  3 13:12:40  kernel: ? __pfx_cleanup_net (net/core/net_namespace.c:586) 
Dec  3 13:12:40  kernel: ? lock_is_held_type (kernel/locking/lockdep.c:5566 kernel/locking/lockdep.c:5897) 
Dec  3 13:12:40  kernel: process_one_work (kernel/workqueue.c:3229) 
Dec  3 13:12:40  kernel: ? __pfx_lock_acquire (kernel/locking/lockdep.c:5793) 
Dec  3 13:12:40  kernel: ? __pfx_process_one_work (kernel/workqueue.c:3131) 
Dec  3 13:12:40  kernel: ? assign_work (kernel/workqueue.c:1200) 
Dec  3 13:12:40  kernel: ? lock_is_held_type (kernel/locking/lockdep.c:5566 kernel/locking/lockdep.c:5897) 
Dec  3 13:12:40  kernel: worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391) 
Dec  3 13:12:40  kernel: ? __kthread_parkme (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
Dec  3 13:12:40  kernel: ? __pfx_worker_thread (kernel/workqueue.c:3337) 
Dec  3 13:12:40  kernel: kthread (kernel/kthread.c:389) 
Dec  3 13:12:40  kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 13:12:40  kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  3 13:12:40  kernel: ? __pfx_kthread (kernel/kthread.c:342) 
Dec  3 13:12:40  kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  3 13:12:40  kernel: </TASK>
Dec  3 13:12:40  kernel:
Dec  3 13:12:40  kernel: Allocated by task 1250:
Dec  3 13:12:40  kernel: kasan_save_stack (mm/kasan/common.c:48) 
Dec  3 13:12:40  kernel: kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
Dec  3 13:12:40  kernel: __kasan_slab_alloc (mm/kasan/common.c:319 mm/kasan/common.c:345) 
Dec  3 13:12:40  kernel: kmem_cache_alloc_noprof (mm/slub.c:4085 mm/slub.c:4134 mm/slub.c:4141) 
Dec  3 13:12:40  kernel: copy_net_ns (net/core/net_namespace.c:421 net/core/net_namespace.c:496) 
Dec  3 13:12:40  kernel: create_new_namespaces (kernel/nsproxy.c:110) 
Dec  3 13:12:40  kernel: unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4)) 
Dec  3 13:12:40  kernel: ksys_unshare (kernel/fork.c:3313) 
Dec  3 13:12:40  kernel: __x64_sys_unshare (kernel/fork.c:3382) 
Dec  3 13:12:40  kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  3 13:12:40  kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  3 13:12:40  kernel:
Dec  3 13:12:40  kernel: Freed by task 13:
Dec  3 13:12:40  kernel: kasan_save_stack (mm/kasan/common.c:48) 
Dec  3 13:12:40  kernel: kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
Dec  3 13:12:40  kernel: kasan_save_free_info (mm/kasan/generic.c:582) 
Dec  3 13:12:40  kernel: __kasan_slab_free (mm/kasan/common.c:271) 
Dec  3 13:12:40  kernel: kmem_cache_free (mm/slub.c:4579 mm/slub.c:4681) 
Dec  3 13:12:40  kernel: cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:655) 
Dec  3 13:12:40  kernel: process_one_work (kernel/workqueue.c:3229) 
Dec  3 13:12:40  kernel: worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391) 
Dec  3 13:12:40  kernel: kthread (kernel/kthread.c:389) 
Dec  3 13:12:40  kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec  3 13:12:40  kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec  3 13:12:40  kernel:
Dec  3 13:12:40  kernel: The buggy address belongs to the object at ffff888166941b40#012 which belongs to the cache net_namespace of size 6720
Dec  3 13:12:40  kernel: The buggy address is located 184 bytes inside of#012 freed 6720-byte region [ffff888166941b40, ffff888166943580)
Dec  3 13:12:40  kernel:
Dec  3 13:12:40  kernel: The buggy address belongs to the physical page:
Dec  3 13:12:40  kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x166940
Dec  3 13:12:40  kernel: head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
Dec  3 13:12:40  kernel: memcg:ffff8881229685c1
Dec  3 13:12:40  kernel: flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
Dec  3 13:12:40  kernel: page_type: f5(slab)
Dec  3 13:12:40  kernel: raw: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
Dec  3 13:12:40  kernel: raw: 0000000000000000 0000000080040004 00000001f5000000 ffff8881229685c1
Dec  3 13:12:40  kernel: head: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
Dec  3 13:12:40  kernel: head: 0000000000000000 0000000080040004 00000001f5000000 ffff8881229685c1
Dec  3 13:12:40  kernel: head: 0017ffffc0000003 ffffea00059a5001 ffffffffffffffff 0000000000000000
Dec  3 13:12:40  kernel: head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
Dec  3 13:12:40  kernel: page dumped because: kasan: bad access detected
Dec  3 13:12:40  kernel:
Dec  3 13:12:40  kernel: Memory state around the buggy address:
Dec  3 13:12:40  kernel: ffff888166941a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
Dec  3 13:12:40  kernel: ffff888166941b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
Dec  3 13:12:40  kernel: >ffff888166941b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  3 13:12:40  kernel:                                                                ^
Dec  3 13:12:40  kernel: ffff888166941c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  3 13:12:40  kernel: ffff888166941c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec  3 13:12:40  kernel: ==================================================================
Dec  3 13:12:40  kernel: Disabling lock debugging due to kernel taint
Dec  3 13:14:14  systemd[1]: var-lib-containers-storage-overlay-compat1591001862-merged.mount: Deactivated successfully.
Dec  3 13:14:14  kernel: evm: overlay not supported
Dec  3 13:14:14  systemd[1]: var-lib-containers-storage-overlay-metacopyx2dcheck2012509683-merged.mount: Deactivated successfully.
Dec  3 13:14:14  podman[5241]: 2024-12-03 13:14:14.444912997 -0500 EST m=+0.123882461 system refresh
Dec  3 13:14:15  systemd[1]: var-lib-containers-storage-overlay.mount: Deactivated successfully.

