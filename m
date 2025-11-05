Return-Path: <netdev+bounces-235830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DECFDC36274
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD6418C60B5
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B532C95F;
	Wed,  5 Nov 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="p1EoThEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3B246335
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354194; cv=none; b=Gd6RP1YeltoWez8Uh4D65mbW02k9nfQqmZGbb4j6pW7vgq/Rk8UfAjw/LbIiWZSbb4GnHXvXVD/1FYXwisvQOdgT9BCEXubanoFXdIaHtRwHOwcAizfmPv3kk4HA0Pz1qKBJDm12A4KYNZRbBFY/+sSwQ3N3Ibb55iqcGIAUBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354194; c=relaxed/simple;
	bh=ce9SvQ9qyWk44opbKqi+f+iTxvWNyIU29ZLTLIhBMmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQYg4I5bjEqOkWVbeRSpHKJnJRrKvw0txdwtV7C0dy66rb06rrglL4ZnlHowAxPUFjReTAf0pqwz95e48gYZHjlacde+8fUx7qevRS/hc5I2zDQfhLM2y6FrPhJAWgLcPabzRo97+Yxsf6RDvvtZIPNY1QvgED7qaZR4WBI+M3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=p1EoThEo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso6824173a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762354191; x=1762958991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNutFVqiZLKWladui0+0ii2bIqCpOonzQgeSmiYc86s=;
        b=p1EoThEox4Wn2uVOexeD237fn7FJodnlSPm4wc1ZXNexCxCWrMDNRvDqk0gsQx8UhB
         QgwpPsPlQHtFqtBXpPf27Nbp0XNAWfjzijbic/iIYz1F41aafL0ILkhdYxuAYZThJdLC
         z39bmdJ5yeSgrS1qW6SIuEnpyMMM68Nqs/IcNqgPwQsubXI+KxnGvKUbB4LN1f8PEmJO
         d99nnJhFfzWBJc7htcmIr00EjReIJQ9HRD1AfiTpmPqUUUCrRhctmbocccg6QHxHG1Rg
         o+1jL3QkaOi65c//GBOADobxgxyiwQFBkty4RyU52l2CX2PhZxsgvQ0rupsB17uOnBjS
         Rkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354191; x=1762958991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNutFVqiZLKWladui0+0ii2bIqCpOonzQgeSmiYc86s=;
        b=WBz9QQV9iOw110eC1GnZQzkVD7pcqNTFG9zKWiWwX2MGzdRnKGN48Fi+IvCSCchbuf
         uK3lvPM6/kWjlHWJkkWMu1byftK9TUpuZoJF8NPMLZaW2BAisoua8bwm5ipZkisskPFb
         OoRYh0eoDSo3xjKcn6wWafuav0A1fH0XWdYUtaIBBWO94zfmpbUIjBHYflUuytPBYDIo
         UEIQmhJWcbnpd5Va02Ev7TFHUbPZLKlrRlLSsTVoJZD4HPqz7+C6bZT2oX9cpwyci4GL
         /5enKxaC02OaUoZR9mB4xcvHIPFB/u4fZB8twFShBiRHSekg8tVBHa39yBT0CMA26R9V
         an+g==
X-Forwarded-Encrypted: i=1; AJvYcCW9kJMbXBZGU9FZWzV5n0RDPNAM+ckdZ7mBUcYl2ivTadFN7ruXgof5FEU6w3QzITkjwFJ1rLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIjt9uudn8ComJeRk8ZmzgOZTkWCjaPX+ZDGUKEY9KkDGh2rI
	HCMRTBlweNwok8BLVzkRi/5PVBzn47rn1MKKV9bH+JlxUxK6LdhtMBcwSJKY+tJ24MY03BEd7fQ
	LeK7Id5jy7ZALvzp/HhuUUI89Rrpkuz9MfBXY+AKC
X-Gm-Gg: ASbGncs/jFLK7XT7n/CVtkiVMZJILOY45/VMUWuMSvs26geAhkDgbrJ/HIYksAeUnWU
	pJnuJ7qDFWrayjncb/S9oBlZNlEOVqLFFuUDz+NBcIyCsy8PCRzZh8SZZ+d4KcwF+T6ftHV+V1J
	qBy4ph7+t4ArT7cYUlvGn+EpUkdR9LrOYpQsYAWx1QrTBYnPaC5uJz16IItR6cd3sv/qPRlK0WV
	vBxDUI00HA8013cQbySLl9Ui74q/FR5UxDC2j5+H1obdWhTxg2cZkXkxmMrTcwNlUHSMPU7wD/c
	+Vq5icVNdcJ2yD2Lfw7JcpIwxqxJfQ4debAa
X-Google-Smtp-Source: AGHT+IFtaXxj+UhBC1sKz5DYp6aBsx9w+5pM1lCdqSXubHqDqhUVuffwO/NgfZLrP9tExB7niohd5bBIrIHMV/2s79w=
X-Received: by 2002:a17:90b:4a44:b0:340:f7d6:dc70 with SMTP id
 98e67ed59e1d1-341a6c48a73mr4638625a91.13.1762354191288; Wed, 05 Nov 2025
 06:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105022213.1981982-1-wangliang74@huawei.com>
In-Reply-To: <20251105022213.1981982-1-wangliang74@huawei.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Nov 2025 09:49:40 -0500
X-Gm-Features: AWmQ_bnukAgyqboISWGHRoA1zxhMBYRfLodtxZAMXGQ_Mc3ncEZMCQuJDCKbiLw
Message-ID: <CAM0EoMn-2ZzbKozqj9y=9yKJT8ANJPqO9UYoiJqFyqUoKfx8RA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Fix possible infinite loop in qdisc_tree_reduce_backlog()
To: Wang Liang <wangliang74@huawei.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:00=E2=80=AFPM Wang Liang <wangliang74@huawei.com> =
wrote:
>
> A soft lockup issue was observed with following log:
>
>   watchdog: BUG: soft lockup - CPU#1 stuck for 104s! [tc:94]
>   CPU: 1 UID: 0 PID: 94 Comm: tc Tainted: G L 6.18.0-rc4-00007-gc9cfc122f=
037 #425 PREEMPT(voluntary)
>   RIP: 0010:qdisc_match_from_root+0x0/0x70
>   Call Trace:
>    <TASK>
>    qdisc_tree_reduce_backlog+0xec/0x110
>    fq_change+0x2e0/0x6a0
>    qdisc_create+0x138/0x4e0
>    tc_modify_qdisc+0x5b9/0x9d0
>    rtnetlink_rcv_msg+0x15a/0x400
>    netlink_rcv_skb+0x55/0x100
>    netlink_unicast+0x257/0x380
>    netlink_sendmsg+0x1e2/0x420
>    ____sys_sendmsg+0x313/0x340
>    ___sys_sendmsg+0x82/0xd0
>    __sys_sendmsg+0x6c/0xd0
>    </TASK>
>
> The issue can be reproduced by:
>   tc qdisc add dev eth0 root noqueue
>   tc qdisc add dev eth0 handle ffff:0 ingress
>   tc qdisc add dev eth0 handle ffe0:0 parent ffff:a fq
>
> A fq qdisc was created in __tc_modify_qdisc(), when the input parent majo=
r
> 'ffff' is equal to the ingress qdisc handle major and the complete parent
> handle is not TC_H_ROOT or TC_H_INGRESS, which leads to a infinite loop i=
n
> qdisc_tree_reduce_backlog().
>

Good test case, but i dont think this is the right solution.
That config is bogus and should never have been accepted by the kernel.
We'll look into it..

cheers,
jamal


> The infinite loop scenario:
>
>   qdisc_tree_reduce_backlog
>
>     // init sch is fq qdisc, parent is ffff000a
>     while ((parentid =3D sch->parent)) {
>
>       // query qdisc by handle ffff0000
>       sch =3D qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
>
>       // return ingress qdisc, sch->parent is fffffff1
>       if (sch =3D=3D NULL) {
>       ...
>     }
>
> Commit 2e95c4384438 ("net/sched: stop qdisc_tree_reduce_backlog on
> TC_H_ROOT") break the loop only when parent TC_H_ROOT is reached. However=
,
> qdisc_lookup_rcu() will return the same qdisc when input an ingress qdisc
> with major 'ffff'. If the parent TC_H_INGRESS is reached, also break the
> loop.
>
> Fixes: 2e95c4384438 ("net/sched: stop qdisc_tree_reduce_backlog on TC_H_R=
OOT")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/sched/sch_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 1e058b46d3e1..b4d6fe6b6812 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -784,7 +784,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int=
 n, int len)
>         drops =3D max_t(int, n, 0);
>         rcu_read_lock();
>         while ((parentid =3D sch->parent)) {
> -               if (parentid =3D=3D TC_H_ROOT)
> +               if (parentid =3D=3D TC_H_ROOT || parentid =3D=3D TC_H_ING=
RESS)
>                         break;
>
>                 if (sch->flags & TCQ_F_NOPARENT)
> --
> 2.34.1
>

