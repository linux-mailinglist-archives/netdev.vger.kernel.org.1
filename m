Return-Path: <netdev+bounces-92570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA08B7F4E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D111F22B83
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8A180A92;
	Tue, 30 Apr 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSG45CwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E5175560
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499912; cv=none; b=EIvqUYWSXODxejUYkUG4HuInqIHbsCDvTrQtnOv99gJ2fdx1xfoMQGxG1gSogtec/UhMozjmrVG8NK7bjIvCJzokKnqZ+hJ1TeUaefTL+4XkiowcY64HKCjr+GdBafLiJL7B0pok2fmWhq73TCkH6DUEAHNRMLVpCOOdotnCUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499912; c=relaxed/simple;
	bh=o+6Dnp4l+2UyO3DCZYS0HIkcLTSUHDcGdRVDYAEexY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIwP4plouNQn+4S9CJs30Vuhbe8zxtfLHl7grZDIIjpqZBpxdQvC0sOWDFNecocYxcC9VG4OA0g/GrWVz5LlUW163Qs4329/hAARCt7Kl+6+hNN6IX0fpct4L34cxSg5ddqDM6qCkoQ0nGQPbxAAsINkPmEPKLS5NRQ1oLycPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSG45CwM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so1719a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714499908; x=1715104708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbWmeRMucgGcne0m2gNEKXHg03bP+Xlb5g+t+6lzCn8=;
        b=dSG45CwMsyAgNpwWWmL63l2kFu9lk42wl+ckXrXMeaw0S7D/89ljT9JcII7aix5+yh
         aeq5Oke61BLKRbmMDFJnP6mPJOKJZyuI5eQ0KlsdvtWZW/krjs7OxH+d53KThc2Uk6/F
         ZCbt3VdiL++zGNjP8uVn5Y7KN28AQnLE20gRhYW7HCJi/0OlAbNiacWub2S6DDm7jlgl
         ZEdJbw2b+ozLzAYd9dFUOPJ6ltS1Uwsc4gkBJlfOs/kmUEBb/giICrdlvf9Eac41RoLD
         FO2y/VWdapNjMOsHKdfAK4/5wiN4lPWa8NpY45K5wyfND5VSDOBIu+Qkvz1oyvppf5yp
         hEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499908; x=1715104708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbWmeRMucgGcne0m2gNEKXHg03bP+Xlb5g+t+6lzCn8=;
        b=OI9jP3Z2tev3XtHmvkISt+ZWpQybiRNwsnGSdwecRBrJWFlD5CfmGjYJC7lUMx0PN9
         5B7zPbVMJ0bcAo255yf1nu4uM1rm+rObeCiy0/VCCp1dpFNH3qAgV9I6CVjltKkFK11T
         TzcvVfUBNEej/XeQykzYTvqXe6XCKmPvIl79q/orfmxtwzPw7fHEbHM3sB3w2kV6JLzi
         SH1WW3zNig8NASnVxp4cTl5fMv8OWHq1+0Ira0fpko4pmLWIT6JGY9G7u0xHPOYrUevz
         VlZUSozBwpj44gtcM8NaW713rltHfPRiyWRFc/8OySmZgWBjbqY6XLw4A/MkIFybSDdq
         JwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpIo+hlGD/CgFBI/XVctGMkOEtLCl78eeQiVHVxTe8+ZJtlqzYewXxdz0xjutgE2kFkKkdOPACnxPaYvPIK1H+O0AplDDG
X-Gm-Message-State: AOJu0Yxvg6msGPUkAnZ4IgynDSsTTC6MJK910zAEvAAzPX8Gq2H6gHTJ
	7g33cQnFDkX+3yWM9r4DT1LMD51s4jThL6MxDibHPRVOnTVoE+2ctoUcJXBPPIR5F/jFkVCXSQ2
	jNL+ZD0srOGxNdheXz+v/NtpvHZth6ED+AeIT
X-Google-Smtp-Source: AGHT+IHF9tnq41ynraAvnhNCiCGaoqhQ8ERxneedte5AjEj7IfV3AhOSoFve2FdmWhTDeWXokyOve8y/IgXEh+rah90=
X-Received: by 2002:a05:6402:35c4:b0:572:9960:c21 with SMTP id
 z4-20020a05640235c400b0057299600c21mr5649edc.7.1714499908231; Tue, 30 Apr
 2024 10:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
In-Reply-To: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 19:58:14 +0200
Message-ID: <CANn89iJJefUheeur5E=bziiqxjqmKXEk3NCO=8em4XVJThExMQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:11=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> Naresh and Eric report several errors (corrupted elements in the dynamic
> key hash list), when running tdc.py or syzbot. The error path of
> qdisc_alloc() and qdisc_create() frees the qdisc memory, but it forgets
> to unregister the lockdep key, thus causing use-after-free like the
> following one:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: slab-use-after-free in lockdep_register_key+0x5f2/0x700
>  Read of size 8 at addr ffff88811236f2a8 by task ip/7925
>
>  CPU: 26 PID: 7925 Comm: ip Kdump: loaded Not tainted 6.9.0-rc2+ #648
>  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  =
07/26/2013
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x7c/0xc0
>   print_report+0xc9/0x610
>   kasan_report+0x89/0xc0
>   lockdep_register_key+0x5f2/0x700
>   qdisc_alloc+0x21d/0xb60
>   qdisc_create_dflt+0x63/0x3c0
>   attach_one_default_qdisc.constprop.37+0x8e/0x170
>   dev_activate+0x4bd/0xc30
>   __dev_open+0x275/0x380
>   __dev_change_flags+0x3f1/0x570
>   dev_change_flags+0x7c/0x160
>   do_setlink+0x1ea1/0x34b0
>   __rtnl_newlink+0x8c9/0x1510
>   rtnl_newlink+0x61/0x90
>   rtnetlink_rcv_msg+0x2f0/0xbc0
>   netlink_rcv_skb+0x120/0x380
>   netlink_unicast+0x420/0x630
>   netlink_sendmsg+0x732/0xbc0
>   __sock_sendmsg+0x1ea/0x280
>   ____sys_sendmsg+0x5a9/0x990
>   ___sys_sendmsg+0xf1/0x180
>   __sys_sendmsg+0xd3/0x180
>   do_syscall_64+0x96/0x180
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>  RIP: 0033:0x7f9503f4fa07
>  Code: 0a 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e =
fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 f=
f ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
>  RSP: 002b:00007fff6c729068 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>  RAX: ffffffffffffffda RBX: 000000006630c681 RCX: 00007f9503f4fa07
>  RDX: 0000000000000000 RSI: 00007fff6c7290d0 RDI: 0000000000000003
>  RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000078
>  R10: 000000000000009b R11: 0000000000000246 R12: 0000000000000001
>  R13: 00007fff6c729180 R14: 0000000000000000 R15: 000055bf67dd9040
>   </TASK>
>
>  Allocated by task 7745:
>   kasan_save_stack+0x1c/0x40
>   kasan_save_track+0x10/0x30
>   __kasan_kmalloc+0x7b/0x90
>   __kmalloc_node+0x1ff/0x460
>   qdisc_alloc+0xae/0xb60
>   qdisc_create+0xdd/0xfb0
>   tc_modify_qdisc+0x37e/0x1960
>   rtnetlink_rcv_msg+0x2f0/0xbc0
>   netlink_rcv_skb+0x120/0x380
>   netlink_unicast+0x420/0x630
>   netlink_sendmsg+0x732/0xbc0
>   __sock_sendmsg+0x1ea/0x280
>   ____sys_sendmsg+0x5a9/0x990
>   ___sys_sendmsg+0xf1/0x180
>   __sys_sendmsg+0xd3/0x180
>   do_syscall_64+0x96/0x180
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>
>  Freed by task 7745:
>   kasan_save_stack+0x1c/0x40
>   kasan_save_track+0x10/0x30
>   kasan_save_free_info+0x36/0x60
>   __kasan_slab_free+0xfe/0x180
>   kfree+0x113/0x380
>   qdisc_create+0xafb/0xfb0
>   tc_modify_qdisc+0x37e/0x1960
>   rtnetlink_rcv_msg+0x2f0/0xbc0
>   netlink_rcv_skb+0x120/0x380
>   netlink_unicast+0x420/0x630
>   netlink_sendmsg+0x732/0xbc0
>   __sock_sendmsg+0x1ea/0x280
>   ____sys_sendmsg+0x5a9/0x990
>   ___sys_sendmsg+0xf1/0x180
>   __sys_sendmsg+0xd3/0x180
>   do_syscall_64+0x96/0x180
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>
> Fix this ensuring that lockdep_unregister_key() is called before the
> qdisc struct is freed, also in the error path of qdisc_create() and
> qdisc_alloc().
>
> Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root =
lock")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/netdev/20240429221706.1492418-1-naresh.ka=
mboju@linaro.org/
> CC: Naresh Kamboju <naresh.kamboju@linaro.org>
> CC: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/sched/sch_api.c     | 1 +
>  net/sched/sch_generic.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 60239378d43f..6292d6d73b72 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1389,6 +1389,7 @@ static struct Qdisc *qdisc_create(struct net_device=
 *dev,
>                 ops->destroy(sch);
>         qdisc_put_stab(rtnl_dereference(sch->stab));
>  err_out3:
> +       lockdep_unregister_key(&sch->root_lock_key);
>         netdev_put(dev, &sch->dev_tracker);
>         qdisc_free(sch);
>  err_out2:

For consistency with the other path, what about this instead ?

This would also  allow a qdisc goten from an rcu lookup to allow its
spinlock to be acquired.
(I am not saying this can happen, but who knows...)

Ie defer the  lockdep_unregister_key() right before the kfree()


diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 31dfd6c7405b01e22fe1b8c80944e2bed7d30ddc..edc9e4d240410d2f98dec04d3fa=
c40983e808c28
100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1042,6 +1042,7 @@ void qdisc_free(struct Qdisc *qdisc)
                free_percpu(qdisc->cpu_qstats);
        }

+       lockdep_unregister_key(&qdisc->root_lock_key);
        kfree(qdisc);
 }

@@ -1070,7 +1071,6 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
        if (ops->destroy)
                ops->destroy(qdisc);

-       lockdep_unregister_key(&qdisc->root_lock_key);
        module_put(ops->owner);
        netdev_put(dev, &qdisc->dev_tracker);

