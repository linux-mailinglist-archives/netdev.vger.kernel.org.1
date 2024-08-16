Return-Path: <netdev+bounces-119100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B287954062
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC4288D6E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6A78291;
	Fri, 16 Aug 2024 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qN1aomps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEF13DDDF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781201; cv=none; b=UdOsm7qtGN8r5d0hNwCn+yQDYDvOwlhSGeFvVB55TL6xu2Z47ErPYF3GxkZhCZ4E7KvT2HR3Q7Eg85OND13lPuD8+4Ny5UJxNxSlf2IRL9iJ/fBJE+ti7PqFwPkQnkeRfupZNKWj3j7dsUa/EB1VEynalXgfRHaOwS8BbJhSt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781201; c=relaxed/simple;
	bh=oqnd9uM8M3tmVHCFOidkOx8Oc7NGi/dUq4+Hb4TwQ4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja6ucoXjB88Zxl12SoaDV2rnge5sjOYdEfHXQ0Ap7WNPyts81wMlxHmoaNheZSmqu4tkEp95qaYwvnSa0tiTU8USfdh6FyfFPsH+3HQ1Hp++jeohZA50z4xjigcmeqtLPn2yY7HgiR+TsazJojy43C9hx85yiHrBashlqnWTcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qN1aomps; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-67682149265so15234057b3.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1723781198; x=1724385998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw4OwQIj+VWyIulQxwy1o3PMK/M68ap5geWrsY5/UcI=;
        b=qN1aompsZHNFtwxIw1IPTk3oNArSL49mjdV9TWSbwNxkjkIZaS6YO6j2V+7uhTwhtK
         KAlrzm93pgZdh01K0iDVF+la/ZGZBE5XE4iG9dVZG/3w7VN6QHuKoLZxnBM/+62MW4nt
         LFEcKIq8ZDBTv82Nqp3A4EvRw1AXeV8LBMWaPzMVF/1c2exBKOwiw/PvsmtZ3TnfPkdR
         ZHKhrDEERDqRMrtbTvBxj/zGqmMoI1T2dbTiZGAH4hUW7698m3waSOD/AN9GyA2reCkm
         RNfXPd26R5UMG/Oz1vMmcIa6bLGWvhjwWY5U0PeZzNJkx/gSaGKD0m/aiA0nMPC09DDM
         bi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723781198; x=1724385998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw4OwQIj+VWyIulQxwy1o3PMK/M68ap5geWrsY5/UcI=;
        b=P7ovxugkSuiSc5kQVGS8d+t6fHx+AqAuDf9MoNG467rCmAYBW1pS7HW8L/h2cCV7A6
         UQ084s87zD51zz5u41MQVAXo/gOr1PKUMFK49HU/v4qq9DrEkvYyXHfHIs7H35Qf5fgf
         Jh6MVyUlYHCcAmhSx7elG4Fh4VXJYXHifgWbGcn9jjTXFlZSl/ul3P4cFdaVi6rBBEId
         lK87nWS0U8ZWdD6/Nacm5hd1q232A5+S1p7gc5t4TsQ5USnpE0IUU9bm4A50T/m6s9J9
         svm86UZ0/40H0Z2VVvz9R+7tUEMKua2ZrFjUMluOuBTXpY5s8Qut1t5U91AgXmE4Z5eb
         i0cA==
X-Gm-Message-State: AOJu0YxPHvZBZQklM3XSugGoImgikc0vHe/7GIcPsOg9s66rySe7QJvU
	A4B9TZhpgIDRL3VhdB2QnqY2q1RanvBSEDKAnjxr/SMZ9B6BfUW+mS083aWO36dSJEIkUsaqLuI
	8XeEYQGcPT9qBVDRXxyOtw8xW2PokAKRYWWZL
X-Google-Smtp-Source: AGHT+IGFyuOwfWy2TEDbQ5U60hklwDz3UWglfGGx4xKAKNdDi3v/v/x1UsJDR7eAuXa+y57yWLxALzGWX0Tj82P3iU0=
X-Received: by 2002:a05:690c:5706:b0:62a:530:472f with SMTP id
 00721157ae682-6b1bbe2fae2mr14972087b3.32.1723781197714; Thu, 15 Aug 2024
 21:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816015355.688153-1-alex000young@gmail.com>
In-Reply-To: <20240816015355.688153-1-alex000young@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Aug 2024 00:06:25 -0400
Message-ID: <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
To: yangzhuorao <alex000young@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	security@kernel.org, xkaneiki@gmail.com, hackerzheng666@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:54=E2=80=AFPM yangzhuorao <alex000young@gmail.com=
> wrote:
>
> There is a uaf bug in net/sched/act_api.c.
> When Thread1 call [1] tcf_action_init_1 to alloc act which saves
> in actions array. If allocation failed, it will go to err path.
> Meanwhile thread2 call tcf_del_walker to delete action in idr.
> So thread 1 in err path [3] tcf_action_destroy will cause
> use-after-free read bug.
>
> Thread1                            Thread2
>  tcf_action_init
>   for(i;i<TCA_ACT_MAX_PRIO;i++)
>    act=3Dtcf_action_init_1 //[1]
>    if(IS_ERR(act))
>     goto err
>    actions[i] =3D act
>                                    tcf_del_walker
>                                     idr_for_each_entry_ul(idr,p,id)
>                                      __tcf_idr_release(p,false,true)
>                                       free_tcf(p) //[2]
>   err:
>    tcf_action_destroy
>     a=3Dactions[i]
>     ops =3D a->ops //[3]
>
> We add lock and unlock in tcf_action_init and tcf_del_walker function
> to aviod race condition.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in tcf_action_destroy+0x138/0x150
> Read of size 8 at addr ffff88806543e100 by task syz-executor156/295
>

Since this is syzkaller induced, do you have a repro?
Also what kernel (trying to see if it was before/after Eric's netlink chang=
es).

cheers,
jamal

> CPU: 0 PID: 295 Comm: syz-executor156 Not tainted 4.19.311 #2
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xcd/0x110 lib/dump_stack.c:118
>  print_address_description+0x60/0x224 mm/kasan/report.c:255
>  kasan_report_error mm/kasan/report.c:353 [inline]
>  kasan_report mm/kasan/report.c:411 [inline]
>  kasan_report.cold+0x9e/0x1c6 mm/kasan/report.c:395
>  tcf_action_destroy+0x138/0x150 net/sched/act_api.c:664
>  tcf_action_init+0x252/0x330 net/sched/act_api.c:961
>  tcf_action_add+0xdb/0x370 net/sched/act_api.c:1326
>  tc_ctl_action+0x327/0x410 net/sched/act_api.c:1381
>  rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
>  netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  __sock_sendmsg+0x126/0x160 net/socket.c:663
>  ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
>  __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
>  do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> RIP: 0033:0x7fc19796b10d
> RSP: 002b:00007fc197910d78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fc1979fe2e0 RCX: 00007fc19796b10d
> RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000004
> RBP: 00007fc1979fe2e8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000246 R12: 00007fc1979fe2ec
> R13: 00007fc1979fc010 R14: 5c56ebd45a42de31 R15: 00007fc1979cb008
>
> Allocated by task 295:
>  __kmalloc+0x89/0x1d0 mm/slub.c:3808
>  kmalloc include/linux/slab.h:520 [inline]
>  kzalloc include/linux/slab.h:709 [inline]
>  tcf_idr_create+0x59/0x5e0 net/sched/act_api.c:361
>  tcf_nat_init+0x4b7/0x850 net/sched/act_nat.c:63
>  tcf_action_init_1+0x981/0xc90 net/sched/act_api.c:879
>  tcf_action_init+0x216/0x330 net/sched/act_api.c:945
>  tcf_action_add+0xdb/0x370 net/sched/act_api.c:1326
>  tc_ctl_action+0x327/0x410 net/sched/act_api.c:1381
>  rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
>  netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  __sock_sendmsg+0x126/0x160 net/socket.c:663
>  ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
>  __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
>  do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>
> Freed by task 275:
>  slab_free_hook mm/slub.c:1391 [inline]
>  slab_free_freelist_hook mm/slub.c:1419 [inline]
>  slab_free mm/slub.c:2998 [inline]
>  kfree+0x8b/0x1a0 mm/slub.c:3963
>  __tcf_action_put+0x114/0x160 net/sched/act_api.c:112
>  __tcf_idr_release net/sched/act_api.c:142 [inline]
>  __tcf_idr_release+0x52/0xe0 net/sched/act_api.c:122
>  tcf_del_walker net/sched/act_api.c:266 [inline]
>  tcf_generic_walker+0x66a/0x9c0 net/sched/act_api.c:292
>  tca_action_flush net/sched/act_api.c:1154 [inline]
>  tca_action_gd+0x8b6/0x15b0 net/sched/act_api.c:1260
>  tc_ctl_action+0x26d/0x410 net/sched/act_api.c:1389
>  rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
>  netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  __sock_sendmsg+0x126/0x160 net/socket.c:663
>  ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
>  __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
>  do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>
> The buggy address belongs to the object at ffff88806543e100
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 0 bytes inside of
>  192-byte region [ffff88806543e100, ffff88806543e1c0)
> The buggy address belongs to the page:
> flags: 0x100000000000100(slab)
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88806543e000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88806543e080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >ffff88806543e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff88806543e180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff88806543e200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> Signed-off-by: yangzhuorao <alex000young@gmail.com>
> ---
>  net/sched/act_api.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index ad0773b20d83..d29ea69ba312 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -261,7 +261,7 @@ static int tcf_del_walker(struct tcf_idrinfo *idrinfo=
, struct sk_buff *skb,
>                 goto nla_put_failure;
>         if (nla_put_string(skb, TCA_KIND, ops->kind))
>                 goto nla_put_failure;
> -
> +       rcu_read_lock();
>         idr_for_each_entry_ul(idr, p, id) {
>                 ret =3D __tcf_idr_release(p, false, true);
>                 if (ret =3D=3D ACT_P_DELETED) {
> @@ -271,12 +271,14 @@ static int tcf_del_walker(struct tcf_idrinfo *idrin=
fo, struct sk_buff *skb,
>                         goto nla_put_failure;
>                 }
>         }
> +       rcu_read_unlock();
>         if (nla_put_u32(skb, TCA_FCNT, n_i))
>                 goto nla_put_failure;
>         nla_nest_end(skb, nest);
>
>         return n_i;
>  nla_put_failure:
> +       rcu_read_unlock();
>         nla_nest_cancel(skb, nest);
>         return ret;
>  }
> @@ -940,7 +942,7 @@ int tcf_action_init(struct net *net, struct tcf_proto=
 *tp, struct nlattr *nla,
>         err =3D nla_parse_nested(tb, TCA_ACT_MAX_PRIO, nla, NULL, extack)=
;
>         if (err < 0)
>                 return err;
> -
> +       rcu_read_lock();
>         for (i =3D 1; i <=3D TCA_ACT_MAX_PRIO && tb[i]; i++) {
>                 act =3D tcf_action_init_1(net, tp, tb[i], est, name, ovr,=
 bind,
>                                         rtnl_held, extack);
> @@ -953,11 +955,12 @@ int tcf_action_init(struct net *net, struct tcf_pro=
to *tp, struct nlattr *nla,
>                 /* Start from index 0 */
>                 actions[i - 1] =3D act;
>         }
> -
> +       rcu_read_unlock();
>         *attr_size =3D tcf_action_full_attrs_size(sz);
>         return i - 1;
>
>  err:
> +       rcu_read_lock();
>         tcf_action_destroy(actions, bind);
>         return err;
>  }
> --
> 2.25.1
>

