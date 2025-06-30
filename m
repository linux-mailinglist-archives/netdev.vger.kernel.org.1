Return-Path: <netdev+bounces-202519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F67AEE1B6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC2F188E7E1
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F828DF16;
	Mon, 30 Jun 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GJqoJwwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86328DEE1
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295429; cv=none; b=DRDyQkQN1DxLREOxdqPEHjFohGYsQG0Nd0gGq4hCqXxjuqxWuq/u0fzMKxkT1rSt9AS7BMPdAAPOEq7nESROO7t37pCVjY8p2gfJCq5NwizjG41tTdKKQpyeZKgkGxKnuxSaZ6d9uTVwePsYZqG8qpLvebAjFnDN1CnwrbCIzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295429; c=relaxed/simple;
	bh=xHxiHMa/Qk0YRqbWdtiyl/yiC22F4UVOpPmdOXBcmrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1+v8XulZ1Lbro/YmOi1zezWAHsev71QZbdFkgT4fYceKQ/dbiCd3xJqedP/reJUoDPCKO1aWzPvtbI8vVH4QrXbPcbzfh7S/cLvFgBI8mijJlUW/Byj7wCJXVz6cpm5zPNOvxPLnnI/SdmOIuFjBFonFp7jIWPREpKE4BdXi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GJqoJwwC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748d982e92cso3593589b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751295427; x=1751900227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxHPUKodZNJ82KIrti5ijze/byKwFmBab5bO+ltJYQU=;
        b=GJqoJwwC8bSYxg4wS3fIZL7bTMZ69155y2IU2RmazrG7u05UagKK9k/sXPHApJFn8b
         Y0xL1JRHETGFlPtw+IjioS76XBiTZUf44tqFeputo7MGE8oGgJ2+wP9kI1nPalJLH3jI
         ullVsnxPfrb5qvFKIEs60EssKtrjILxhaWiOywOTZMtoUpQ//Vh6Ie2boDXF2Bki+EV0
         F7hiStVzeTHwDPTYc1n7UcIsrYXc3n6ozT5UXqCByCcYbrcfjZSfL4XoVm03qa0yeary
         RR+9B/E5UD6YGG83Lpf6fJNiuKovwQZsZ6Z4GZnLdOEZG0AauLVmjQKnqcSlkWhI3Vsj
         Y4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295427; x=1751900227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxHPUKodZNJ82KIrti5ijze/byKwFmBab5bO+ltJYQU=;
        b=IO/pvK0ptAvdW5JKd2BNU2QyhCWUlkNJV/08mDYJt4hrpxQ08khjcYJNPLxkK5PBo1
         dXsSrnMIHqzseLv5/zlEz1OcAJ6fSgCje+vrN27TXnK+bKPvAaxtgXqSctKpqiqXNFVy
         xg9qjR4nO/r2DTT+5p1vmlq5O4w1lm/rvwzJ1kZv09/fHyUv4v+dy58iGBwZhPwELRIA
         FZEGdqtvtsM/jxuZtCL4oIGFyuhOB9CHikzDvbkk8XFJNudsL8Inn8e+sJd3KdcISTdb
         Z/SYb/05AI702067M7FpUa58ezQZdNCydCw+0yJrS6VLn/nzq+p2H0BnnJ0e9Qlitfg2
         gSuQ==
X-Gm-Message-State: AOJu0Yzvivrsx4QKeRCCkERR5BCNaXxWnN4K3Y5Aq46UNHhq2kjtyArq
	00KyMXwNthVoca6HkqcWi2CCBSp46jVF873AJyVCX6b7RRPpjFIEKSgPtXd48RQjiDAF7QYq15s
	jfmbTVHrcIN2gIc93963UHdwU0tXlUSmisAbeLBZE
X-Gm-Gg: ASbGncs+4f+p7nJb6Y1ubfOlZTetZ6IvWB9CKkevqcL2+2r+xf1K4VkrtT+wIMQajvJ
	jgjsNCS1vMpcjMtrxGXWRDdQUDxynjgBHV5TjGjOHzGDQJREf8j96ZzWom86XCeIlzeFXeF41Nf
	YOV64NqEst6ySt7/WdD0lxux5r+1flnyONpzb8QS7N1g==
X-Google-Smtp-Source: AGHT+IGFzjtybEcn11ljCwLpZ+9PKulOarn9DDtyEa6VVtXVCp1JXQdZhxb/RW/NLXXD5IeZ3kkrzJGXDE+Ku45peB4=
X-Received: by 2002:a05:6a00:1a8e:b0:749:122f:5fe5 with SMTP id
 d2e1a72fcca58-74af6f9cc66mr20030274b3a.18.1751295427033; Mon, 30 Jun 2025
 07:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain> <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com> <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com> <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <13f558f2-3c0d-4ec7-8a73-c36d8962fecc@mojatatu.com> <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>
In-Reply-To: <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Jun 2025 10:56:55 -0400
X-Gm-Features: Ac12FXyIqNd6tbdppzwBlKacCvV7zSNKYIu46i_K68mUhyEG04YA0D9xp99i1-A
Message-ID: <CAM0EoMnDSJTWuxw6P3=oOAjjOe9Pbn6FbCZmByx3B9qfPceVeg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Always pass notifications when child class
 becomes empty
To: Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Mingi Cho <mincho@theori.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 9:27=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> =
wrote:
>
> Certain classful qdiscs may invoke their classes' dequeue handler on an
> enqueue operation. This may unexpectedly empty the child qdisc and thus
> make an in-flight class passive via qlen_notify(). Most qdiscs do not
> expect such behaviour at this point in time and may re-activate the
> class eventually anyways which will lead to a use-after-free.
>
> The referenced fix commit attempted to fix this behavior for the HFSC
> case by moving the backlog accounting around, though this turned out to
> be incomplete since the parent's parent may run into the issue too.
> The following reproducer demonstrates this use-after-free:
>
>     tc qdisc add dev lo root handle 1: drr
>     tc filter add dev lo parent 1: basic classid 1:1
>     tc class add dev lo parent 1: classid 1:1 drr
>     tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
>     tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
>     tc qdisc add dev lo parent 2:1 handle 3: netem
>     tc qdisc add dev lo parent 3:1 handle 4: blackhole
>
>     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
>     tc class delete dev lo classid 1:1
>     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
>
> Since backlog accounting issues leading to a use-after-frees on stale
> class pointers is a recurring pattern at this point, this patch takes
> a different approach. Instead of trying to fix the accounting, the patch
> ensures that qdisc_tree_reduce_backlog always calls qlen_notify when
> the child qdisc is empty. This solves the problem because deletion of
> qdiscs always involves a call to qdisc_reset() and / or
> qdisc_purge_queue() which ultimately resets its qlen to 0 thus causing
> the following qdisc_tree_reduce_backlog() to report to the parent. Note
> that this may call qlen_notify on passive classes multiple times. This
> is not a problem after the recent patch series that made all the
> classful qdiscs qlen_notify() handlers idempotent.
>
> Fixes: 3f981138109f ("sch_hfsc: Fix qlen accounting bug when using peek i=
n hfsc_enqueue()")
> Signed-off-by: Lion Ackermann <nnamrec@gmail.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  net/sched/sch_api.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index c5e3673aadbe..d8a33486c511 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_device *de=
v)
>
>  void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>  {
> -       bool qdisc_is_offloaded =3D sch->flags & TCQ_F_OFFLOADED;
>         const struct Qdisc_class_ops *cops;
>         unsigned long cl;
>         u32 parentid;
>         bool notify;
>         int drops;
>
> -       if (n =3D=3D 0 && len =3D=3D 0)
> -               return;
>         drops =3D max_t(int, n, 0);
>         rcu_read_lock();
>         while ((parentid =3D sch->parent)) {
> @@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, in=
t n, int len)
>
>                 if (sch->flags & TCQ_F_NOPARENT)
>                         break;
> -               /* Notify parent qdisc only if child qdisc becomes empty.
> -                *
> -                * If child was empty even before update then backlog
> -                * counter is screwed and we skip notification because
> -                * parent class is already passive.
> -                *
> -                * If the original child was offloaded then it is allowed
> -                * to be seem as empty, so the parent is notified anyway.
> -                */
> -               notify =3D !sch->q.qlen && !WARN_ON_ONCE(!n &&
> -                                                      !qdisc_is_offloade=
d);
> +               /* Notify parent qdisc only if child qdisc becomes empty.=
 */
> +               notify =3D !sch->q.qlen;
>                 /* TODO: perform the search on a per txq basis */
>                 sch =3D qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parenti=
d));
>                 if (sch =3D=3D NULL) {
> @@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int=
 n, int len)
>                 }
>                 cops =3D sch->ops->cl_ops;
>                 if (notify && cops->qlen_notify) {
> +                       /* Note that qlen_notify must be idempotent as it=
 may get called
> +                        * multiple times.
> +                        */
>                         cl =3D cops->find(sch, parentid);
>                         cops->qlen_notify(sch, cl);
>                 }
> --
> 2.49.0
>
>

