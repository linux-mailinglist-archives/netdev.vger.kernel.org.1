Return-Path: <netdev+bounces-84846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3294F898780
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524461C2189B
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAF12883C;
	Thu,  4 Apr 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MgqCntZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39212837A
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233583; cv=none; b=A7orgsQe/FuYKF5LDXzsJl+f1vSdTm8oqV3V3a1twcQJ5llRgX6mRq5LU1u08CVMaoXcqyitScNEvFeq8r6TUpsIA7biCtNsO0PQvyVCQ6+nvgyUgHsmE7EFQQuSPTZITv4bo+x5O8Qh02CV6JqeX7M0Z1A901y5fzhlqNFPVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233583; c=relaxed/simple;
	bh=LMnMkfX8xOOn0CmPJiEbh+QF2j1hw2yK7rQEEDEDvRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLjqQDjixaUng/+oPkReqnKAf2TUZJ9xu7bqqgl/ywOwVEx7LTvoKUB6DbV/arsZ0lD66xUvJqBrMAOvxGQOAkpEEmmHXFrd3FsTLf2RRkL694aKKFcn9LMKO0mVwkUBekrJqHywS7QUQr4uSqmCA67xcd8x46pg7hT8FIMspVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MgqCntZg; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso940667276.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712233581; x=1712838381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4DWd2blALMF74vrBqgN47u62WeqBas0RWjaKumZ6h8=;
        b=MgqCntZg+llwT+ykusFf9us79i9IxlgNY5Te0fpFZUSjbLODNmPWbm/PvMosKCPjS2
         euW47+cZdZrB1gipZGV2pI7/LKRNys63kipMPkp4/rISv716ctidTGAmWj6tLmfC8eQH
         vMllUocEjd7Ox0tLOqBuMBd/zbo0sLfmLNWD/P5LHnM0EIPKpSi3PndCQje2ZfStSNdV
         RJifzOnyQQGR/tG+MSa9DVzDS9Izk8HWVUyxHOjDGl/9sK1ol0IdgWbKxQxxrupjQArO
         KFVspwX/Fyhf2KiPrbZ8foLfH6RCvM21LWXddIszGcCZ43mWDEpzJA85CQ3cBuQj9OJS
         KpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233581; x=1712838381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4DWd2blALMF74vrBqgN47u62WeqBas0RWjaKumZ6h8=;
        b=mIWCg8WMKe9xoEF6a5OyMw4Z5kE4lW9jbZjStZpFGlbf5Vzu6G94WlXI9S1BkY0yUx
         R/zvF2vPuJ0ri5SFcdm5ORWecGEbwEclYxDQCFkadjKwsZLAjSjqHVqgYBU3XinXlwMi
         ouNqR8RqoJnqRx6H63+JclDkcR9fr3BGJUcoro3AQASSsOgg2nBlIHEVBJjz/MdG50Ho
         bpokjf5Sx4Us4faZ03tr4HosVcVJtkqKSuFhZXL9LZtPQpo0azrsu3VbYOSE0Lch52yu
         /k1YFAM9AWW/MTjQeossDOZNftU/7p5wVq/o8cXAovboNaHYy/lhXW9zCBrK+jaVxygG
         /MrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPoAzHylVR8eXJc31J9TzzK/M9oNAHeXBrmjTkzaY7TjYtFsnVuN6Q1/XVTHqS0krPbUZnxSzs3+aIUBV+fK3ytFxg9YJy
X-Gm-Message-State: AOJu0YxciYb99E0z2b9UIocWQebzYiOPKZ5ipurbF5gKtSzBdGwRwmN6
	moFB+8GvM5hWgQZILQVF4tZDKQ/GRV5mRtSGQrh1CPvmmn1s2D47Eyz5FV+MICn3wQbT8hq0fw8
	u4lWssM+O06zKLpk65fmj7DYQCPYIn+pyLpJIKe6auMMHZiA=
X-Google-Smtp-Source: AGHT+IEdXFk84YuXigvbhte8oL95aookGzw4yzSC2IaUK87vntkXVP3NQyldugPuc6MRLk3YMf+k/fYC/RXIb8I9YIQ=
X-Received: by 2002:a25:874d:0:b0:dcc:e187:6ceb with SMTP id
 e13-20020a25874d000000b00dcce1876cebmr2642722ybn.17.1712233580816; Thu, 04
 Apr 2024 05:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403130908.93421-1-edumazet@google.com>
In-Reply-To: <20240403130908.93421-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Apr 2024 08:26:09 -0400
Message-ID: <CAM0EoM=4CffEs3TpypU5CZ_C-xe2D5nm=Jp7L9Kym+oF+j_HCg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_skbmod: prevent kernel-infoleak
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:09=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> syzbot found that tcf_skbmod_dump() was copying four bytes
> from kernel stack to user space [1].
>
> The issue here is that 'struct tc_skbmod' has a four bytes hole.
>
> We need to clear the structure before filling fields.
>
> [1]
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/inst=
rumented.h:114 [inline]
>  BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inli=
ne]
>  BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 =
[inline]
>  BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_it=
er.h:245 [inline]
>  BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_ite=
r.h:271 [inline]
>  BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c=
:185
>   instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>   copy_to_user_iter lib/iov_iter.c:24 [inline]
>   iterate_ubuf include/linux/iov_iter.h:29 [inline]
>   iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>   iterate_and_advance include/linux/iov_iter.h:271 [inline]
>   _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
>   copy_to_iter include/linux/uio.h:196 [inline]
>   simple_copy_to_iter net/core/datagram.c:532 [inline]
>   __skb_datagram_iter+0x185/0x1000 net/core/datagram.c:420
>   skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:546
>   skb_copy_datagram_msg include/linux/skbuff.h:4050 [inline]
>   netlink_recvmsg+0x432/0x1610 net/netlink/af_netlink.c:1962
>   sock_recvmsg_nosec net/socket.c:1046 [inline]
>   sock_recvmsg+0x2c4/0x340 net/socket.c:1068
>   __sys_recvfrom+0x35a/0x5f0 net/socket.c:2242
>   __do_sys_recvfrom net/socket.c:2260 [inline]
>   __se_sys_recvfrom net/socket.c:2256 [inline]
>   __x64_sys_recvfrom+0x126/0x1d0 net/socket.c:2256
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> Uninit was stored to memory at:
>   pskb_expand_head+0x30f/0x19d0 net/core/skbuff.c:2253
>   netlink_trim+0x2c2/0x330 net/netlink/af_netlink.c:1317
>   netlink_unicast+0x9f/0x1260 net/netlink/af_netlink.c:1351
>   nlmsg_unicast include/net/netlink.h:1144 [inline]
>   nlmsg_notify+0x21d/0x2f0 net/netlink/af_netlink.c:2610
>   rtnetlink_send+0x73/0x90 net/core/rtnetlink.c:741
>   rtnetlink_maybe_send include/linux/rtnetlink.h:17 [inline]
>   tcf_add_notify net/sched/act_api.c:2048 [inline]
>   tcf_action_add net/sched/act_api.c:2071 [inline]
>   tc_ctl_action+0x146e/0x19d0 net/sched/act_api.c:2119
>   rtnetlink_rcv_msg+0x1737/0x1900 net/core/rtnetlink.c:6595
>   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2559
>   rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6613
>   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>   netlink_unicast+0xf4c/0x1260 net/netlink/af_netlink.c:1361
>   netlink_sendmsg+0x10df/0x11f0 net/netlink/af_netlink.c:1905
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>   __sys_sendmsg net/socket.c:2667 [inline]
>   __do_sys_sendmsg net/socket.c:2676 [inline]
>   __se_sys_sendmsg net/socket.c:2674 [inline]
>   __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> Uninit was stored to memory at:
>   __nla_put lib/nlattr.c:1041 [inline]
>   nla_put+0x1c6/0x230 lib/nlattr.c:1099
>   tcf_skbmod_dump+0x23f/0xc20 net/sched/act_skbmod.c:256
>   tcf_action_dump_old net/sched/act_api.c:1191 [inline]
>   tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1227
>   tcf_action_dump+0x1fd/0x460 net/sched/act_api.c:1251
>   tca_get_fill+0x519/0x7a0 net/sched/act_api.c:1628
>   tcf_add_notify_msg net/sched/act_api.c:2023 [inline]
>   tcf_add_notify net/sched/act_api.c:2042 [inline]
>   tcf_action_add net/sched/act_api.c:2071 [inline]
>   tc_ctl_action+0x1365/0x19d0 net/sched/act_api.c:2119
>   rtnetlink_rcv_msg+0x1737/0x1900 net/core/rtnetlink.c:6595
>   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2559
>   rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6613
>   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>   netlink_unicast+0xf4c/0x1260 net/netlink/af_netlink.c:1361
>   netlink_sendmsg+0x10df/0x11f0 net/netlink/af_netlink.c:1905
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>   __sys_sendmsg net/socket.c:2667 [inline]
>   __do_sys_sendmsg net/socket.c:2676 [inline]
>   __se_sys_sendmsg net/socket.c:2674 [inline]
>   __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> Local variable opt created at:
>   tcf_skbmod_dump+0x9d/0xc20 net/sched/act_skbmod.c:244
>   tcf_action_dump_old net/sched/act_api.c:1191 [inline]
>   tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1227
>
> Bytes 188-191 of 248 are uninitialized
> Memory access of size 248 starts at ffff888117697680
> Data copied to user address 00007ffe56d855f0
>
> Fixes: 86da71b57383 ("net_sched: Introduce skbmod action")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_skbmod.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
> index 39945b139c4817584fb9803b9e65c89fef68eca0..cd0accaf844a18e4a6a626adb=
a5fae05df66b0a3 100644
> --- a/net/sched/act_skbmod.c
> +++ b/net/sched/act_skbmod.c
> @@ -241,13 +241,13 @@ static int tcf_skbmod_dump(struct sk_buff *skb, str=
uct tc_action *a,
>         struct tcf_skbmod *d =3D to_skbmod(a);
>         unsigned char *b =3D skb_tail_pointer(skb);
>         struct tcf_skbmod_params  *p;
> -       struct tc_skbmod opt =3D {
> -               .index   =3D d->tcf_index,
> -               .refcnt  =3D refcount_read(&d->tcf_refcnt) - ref,
> -               .bindcnt =3D atomic_read(&d->tcf_bindcnt) - bind,
> -       };
> +       struct tc_skbmod opt;
>         struct tcf_t t;
>
> +       memset(&opt, 0, sizeof(opt));
> +       opt.index   =3D d->tcf_index;
> +       opt.refcnt  =3D refcount_read(&d->tcf_refcnt) - ref,
> +       opt.bindcnt =3D atomic_read(&d->tcf_bindcnt) - bind;
>         spin_lock_bh(&d->tcf_lock);
>         opt.action =3D d->tcf_action;
>         p =3D rcu_dereference_protected(d->skbmod_p,
> --
> 2.44.0.478.gd926399ef9-goog
>

