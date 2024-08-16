Return-Path: <netdev+bounces-119124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD395429E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56471F219D9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C112EBE7;
	Fri, 16 Aug 2024 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Jh+rY8yf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E77139CEF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792828; cv=none; b=WlvVaYYN8tsR6XJ/hinLABHq+q4aKJ+H0oDA8/N7HDbqWfCnvPfNZj93pEufu0NDzviTcGTCVDcDOwQhURPJ+gfXtDxqHEzrqCpL8F9xsVQ9GoQ64+RFcrUvYybE3+JuV5ofs/i20rimKmqBDBsAAqZE2qNoJDbscylZKQUW0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792828; c=relaxed/simple;
	bh=FBdsxbZkd/XyWzqhUS+S8phQd/eB6ljWnJRZVKicTlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f56R0yaRBjCoez0i6+N9y8eSWzhJEvDUo7Q5QzGnzlngq110UHMYB9Z4SUlTi+/YR2EV7AyPpFri6Eea4TlvHAI/hUEedjVDoi5D88cVkLO6i6AqYM+D55MfgC+sSBqloXtlfnZhPBjlIw15XBK/G7lwPUG/hYbL2jGNY3WYE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Jh+rY8yf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3718acbc87fso690745f8f.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723792823; x=1724397623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3snyla+eJmB32kFu1uE1ex9HKSxBtPWetc+mZ58IGKM=;
        b=Jh+rY8yfUTnHBa0GOBafif9rMkOrJ1rN0T1egXDGKyXDislvXXNQcW4rKaK2ZWSJF7
         A7b1115eIi0ABtGYK3Z2niI/7x67zGEwOYpOJF2O8PCOSwxc74ERTQeF11wz9Jf/perB
         3WFVBuaevhZtS2mlAmqfnDlqEeoY8UISAj9Gf/n0e30hKPF9W68XZqZ3kSsp+xi34uqk
         Fxs7BBfOIkGAbFQ8GHG+fB4wc9bTb8rCwZx/IHNPv9pEmBUTKm3GRM4dL8QLzFLBiNsH
         g43RwqKl+oZeXoG1RarXOcW2CyK2LcKqe3+sTB7Cimc9jDuzjfMvtlYPiUBii9R4NobY
         BHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792823; x=1724397623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3snyla+eJmB32kFu1uE1ex9HKSxBtPWetc+mZ58IGKM=;
        b=tcrxqz5vafB+qAYoQGw+/6KWdLQ/5867UUQP7l/TVQPw9Tk8CDpB3GmAPP54Tpz7Ck
         2r4hE+S7VhCgLxUc7O6E3rfbQDVQ+PsvHZJ/0PvbSu5/k8E+FYr1GU8CD8QWxD5L617e
         3Yi9gSM8ZfmQyRf8par1+A8vdg2XQUXt2HtvduUx5uLgtolli+dLtcMEuwEvW4hW1hqe
         4Qfq29zjxqpDQdkKOeE3gFKthfML3Uwwo+b+r0dhQcepaQtzUAR9wNnCTKRlphiYQ2CZ
         PZqHAYAv6M13dK5SfKmcFFeMrVD9CwkTMbEZVVWaJHAGgspippa6xkhD5umbs5i81nIp
         2JHw==
X-Gm-Message-State: AOJu0YwNgyozknqOraENMt6fLDdmCdf4+ZDyTZWoZvHvgF8Pp7bmYCIk
	YALkoXehgZIzqYM/y12LLppv18BgDfccYKzP14WLHV4Nfd9n+tdgfYoj0Rmwo7o=
X-Google-Smtp-Source: AGHT+IFoaRPNnOwLK9w6p8NpJI6HT5xaUSv9rvEcER9vXxKKPqyNl34k5Tu5tjMQYgTIRY0FLlJm1Q==
X-Received: by 2002:a05:6000:12c7:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-3719431519fmr945821f8f.8.1723792822997;
        Fri, 16 Aug 2024 00:20:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm2999669f8f.39.2024.08.16.00.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:20:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 09:20:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: yangzhuorao <alex000young@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, davem@davemloft.net, security@kernel.org,
	xkaneiki@gmail.com, hackerzheng666@gmail.com
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
Message-ID: <Zr79s6C-2FoLhoWj@nanopsycho.orion>
References: <20240816015355.688153-1-alex000young@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816015355.688153-1-alex000young@gmail.com>

Fri, Aug 16, 2024 at 03:53:55AM CEST, alex000young@gmail.com wrote:
>There is a uaf bug in net/sched/act_api.c.
>When Thread1 call [1] tcf_action_init_1 to alloc act which saves
>in actions array. If allocation failed, it will go to err path.
>Meanwhile thread2 call tcf_del_walker to delete action in idr.
>So thread 1 in err path [3] tcf_action_destroy will cause
>use-after-free read bug.
>
>Thread1                            Thread2
> tcf_action_init
>  for(i;i<TCA_ACT_MAX_PRIO;i++)
>   act=tcf_action_init_1 //[1]
>   if(IS_ERR(act))
>    goto err
>   actions[i] = act
>                                   tcf_del_walker
>                                    idr_for_each_entry_ul(idr,p,id)
>                                     __tcf_idr_release(p,false,true)
>                                      free_tcf(p) //[2]
>  err:
>   tcf_action_destroy
>    a=actions[i]
>    ops = a->ops //[3]
>
>We add lock and unlock in tcf_action_init and tcf_del_walker function

Who's "we"? Be imperative, tell the codebase what to do in order to fix
this bug.


>to aviod race condition.
>
>==================================================================
>BUG: KASAN: use-after-free in tcf_action_destroy+0x138/0x150
>Read of size 8 at addr ffff88806543e100 by task syz-executor156/295
>
>CPU: 0 PID: 295 Comm: syz-executor156 Not tainted 4.19.311 #2
>Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0xcd/0x110 lib/dump_stack.c:118
> print_address_description+0x60/0x224 mm/kasan/report.c:255
> kasan_report_error mm/kasan/report.c:353 [inline]
> kasan_report mm/kasan/report.c:411 [inline]
> kasan_report.cold+0x9e/0x1c6 mm/kasan/report.c:395
> tcf_action_destroy+0x138/0x150 net/sched/act_api.c:664
> tcf_action_init+0x252/0x330 net/sched/act_api.c:961
> tcf_action_add+0xdb/0x370 net/sched/act_api.c:1326
> tc_ctl_action+0x327/0x410 net/sched/act_api.c:1381
> rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
> netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
> netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
> netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
> sock_sendmsg_nosec net/socket.c:652 [inline]
> __sock_sendmsg+0x126/0x160 net/socket.c:663
> ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
> __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
> do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
> entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>RIP: 0033:0x7fc19796b10d
>RSP: 002b:00007fc197910d78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>RAX: ffffffffffffffda RBX: 00007fc1979fe2e0 RCX: 00007fc19796b10d
>RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000004
>RBP: 00007fc1979fe2e8 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000002 R11: 0000000000000246 R12: 00007fc1979fe2ec
>R13: 00007fc1979fc010 R14: 5c56ebd45a42de31 R15: 00007fc1979cb008
>
>Allocated by task 295:
> __kmalloc+0x89/0x1d0 mm/slub.c:3808
> kmalloc include/linux/slab.h:520 [inline]
> kzalloc include/linux/slab.h:709 [inline]
> tcf_idr_create+0x59/0x5e0 net/sched/act_api.c:361
> tcf_nat_init+0x4b7/0x850 net/sched/act_nat.c:63
> tcf_action_init_1+0x981/0xc90 net/sched/act_api.c:879
> tcf_action_init+0x216/0x330 net/sched/act_api.c:945
> tcf_action_add+0xdb/0x370 net/sched/act_api.c:1326
> tc_ctl_action+0x327/0x410 net/sched/act_api.c:1381
> rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
> netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
> netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
> netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
> sock_sendmsg_nosec net/socket.c:652 [inline]
> __sock_sendmsg+0x126/0x160 net/socket.c:663
> ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
> __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
> do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
> entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>
>Freed by task 275:
> slab_free_hook mm/slub.c:1391 [inline]
> slab_free_freelist_hook mm/slub.c:1419 [inline]
> slab_free mm/slub.c:2998 [inline]
> kfree+0x8b/0x1a0 mm/slub.c:3963
> __tcf_action_put+0x114/0x160 net/sched/act_api.c:112
> __tcf_idr_release net/sched/act_api.c:142 [inline]
> __tcf_idr_release+0x52/0xe0 net/sched/act_api.c:122
> tcf_del_walker net/sched/act_api.c:266 [inline]
> tcf_generic_walker+0x66a/0x9c0 net/sched/act_api.c:292
> tca_action_flush net/sched/act_api.c:1154 [inline]
> tca_action_gd+0x8b6/0x15b0 net/sched/act_api.c:1260
> tc_ctl_action+0x26d/0x410 net/sched/act_api.c:1389
> rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
> netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
> netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
> netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
> sock_sendmsg_nosec net/socket.c:652 [inline]
> __sock_sendmsg+0x126/0x160 net/socket.c:663
> ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
> __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
> do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
> entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>
>The buggy address belongs to the object at ffff88806543e100
> which belongs to the cache kmalloc-192 of size 192
>The buggy address is located 0 bytes inside of
> 192-byte region [ffff88806543e100, ffff88806543e1c0)
>The buggy address belongs to the page:
>flags: 0x100000000000100(slab)
>page dumped because: kasan: bad access detected
>
>Memory state around the buggy address:
> ffff88806543e000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88806543e080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>ffff88806543e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                   ^
> ffff88806543e180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff88806543e200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>

You are missing tags. "Fixes" at least.


>Signed-off-by: yangzhuorao <alex000young@gmail.com>

Usually, name starts with capital letter and most often it is multiple
words, yours is different?


>---
> net/sched/act_api.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>index ad0773b20d83..d29ea69ba312 100644
>--- a/net/sched/act_api.c
>+++ b/net/sched/act_api.c
>@@ -261,7 +261,7 @@ static int tcf_del_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
> 		goto nla_put_failure;
> 	if (nla_put_string(skb, TCA_KIND, ops->kind))
> 		goto nla_put_failure;
>-
>+	rcu_read_lock();
> 	idr_for_each_entry_ul(idr, p, id) {
> 		ret = __tcf_idr_release(p, false, true);
> 		if (ret == ACT_P_DELETED) {
>@@ -271,12 +271,14 @@ static int tcf_del_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
> 			goto nla_put_failure;
> 		}
> 	}
>+	rcu_read_unlock();
> 	if (nla_put_u32(skb, TCA_FCNT, n_i))
> 		goto nla_put_failure;
> 	nla_nest_end(skb, nest);
> 
> 	return n_i;
> nla_put_failure:
>+	rcu_read_unlock();
> 	nla_nest_cancel(skb, nest);
> 	return ret;
> }
>@@ -940,7 +942,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
> 	err = nla_parse_nested(tb, TCA_ACT_MAX_PRIO, nla, NULL, extack);
> 	if (err < 0)
> 		return err;
>-
>+	rcu_read_lock();
> 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
> 		act = tcf_action_init_1(net, tp, tb[i], est, name, ovr, bind,
> 					rtnl_held, extack);
>@@ -953,11 +955,12 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
> 		/* Start from index 0 */
> 		actions[i - 1] = act;
> 	}
>-
>+	rcu_read_unlock();


Can you please describe in details, how exactly you fix this issue. I'm
asking because the rcu_read_lock section here looks to me very
suspicious.



> 	*attr_size = tcf_action_full_attrs_size(sz);
> 	return i - 1;
> 
> err:
>+	rcu_read_lock();
> 	tcf_action_destroy(actions, bind);
> 	return err;
> }
>-- 
>2.25.1
>

