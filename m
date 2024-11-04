Return-Path: <netdev+bounces-141466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C299BB0B2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392DB280F02
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E01AF0DD;
	Mon,  4 Nov 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnLaJHt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6C18C020
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715078; cv=none; b=LmRb1LbcZ/gJ57G95cTyRXv/qr74kgtdmKbjBlRBv7ouChdwVIOl8lV5RoJC9aGGd1XGcXU53HbCsb0VlNq7VWA5IJKLzOGg9gjdls3YBUEXH/6IpC+aMdVoQDYHNUiXU3hwRz0IdUWxCSkXjGG8QhfHXh3/l+g4BzGgYnne1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715078; c=relaxed/simple;
	bh=Htk8iB0YyfeGsbZQ/ruz17kzjXwa9UodBdhyv2GOWis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpaURHmB7g5lnxQz6c217aFANUZH1hzXWEIQLo1txBGT6sRh4qoTAkHa/Ue34yCOvyukya9eWX0rU6J/KqONTueKoi82MJO5H6980j1Sw1FiRib7nDlmrPOJ+sX4z3ft+gHuWrGKaomfTpkxLhGTRu4nhyYeuV5nruDZzvkNQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnLaJHt3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cb74434bc5so4744712a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 02:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730715075; x=1731319875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrZiXdNbJPgRaK5srWLUA0yLayHAjiVxxaDrSVczzp0=;
        b=GnLaJHt3B7TEcZF1lGrjPcy+xB2dgJptnCnhtvB7tkq9AovIftHpqHFSvgkceAVw2T
         evbkMVpWGbkagTi/BTsmwHbiQbnmp5nn9bIa9/CUzIkooVu0pu4lbXmPrGES/BfRrTdj
         gRfb62JstfXDuj8z5HQEvgvWBxUuKfgVBnqcc2xXGQ7smPjM3Oz8XbxF7Z4g0VN9I0ro
         yBa8+Hvu4AmtlrZJtnKq7m2L2YY5ku+AnbR9id4V0yhpfzMSGpQwCFq0h/R1xPCOWYNi
         pYB7t85dmPQx/n9DjjG1YnP8UZGYDjY4/4qAEyI5ImUxPS+XWgxPj1hy5BHdafBi9aM2
         TfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715075; x=1731319875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrZiXdNbJPgRaK5srWLUA0yLayHAjiVxxaDrSVczzp0=;
        b=hJsc1JCIytOtL9HObJDuCpzi/4/JaJvpnOYkFMIf2ak/jbVHMju5MPg8c0/b6C6fxW
         YbV5GPZuBOHXgOkExZNVMTULpMHiVaq59YOfakSP379OMFuTLDoJCg/QO5LpWEfTO8nH
         HxNLrFeGmUYH9my81q9t7MX0l75jtEKtQAZYxOe6kuzF7OF4FlLuhLWX92K6LT0BG85v
         I9yseD7j60tOe6YItyU6qyMTFpDlz1ADpiwuzM/Lt4hR1PfW/doa60XYIbH6DjwEgrQ8
         ol+gJdDPYsKc+I0UaH48m2DUu/mnBSxIMf28rGrfJEtJNZg/sZgS+PtEnNw+vzhOMxBZ
         N0jA==
X-Forwarded-Encrypted: i=1; AJvYcCWCn//z61RuklUo6C+3ndFjr/AhAzLXhHWBlFbuYk5yiwUH8w4RYxgrcd74Rv8OD+TyClRukO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiioDY3MuRnXHDO8+egTxX7cqgoVvQehHcEERjNXPtwiVkhbp8
	DsC7qNAgvqRlwDCK2gR+MIVN6YyKg6HwUB05EJeLkCxAbcn9JLl9TfhbT2JRrh8YtpIyxo6cCxL
	7DdHZGmbmzxkkgSEKUwMjlQiBmxLw47EwP7Yd
X-Google-Smtp-Source: AGHT+IEVl3eW2fVJ2NFHDbpSOcHl98sRk0Sc9nqAESc1UlAiSXWNDiASAyL5JrJXzzeOmFiua8QR2FDC2auoHSrhGGY=
X-Received: by 2002:a05:6402:3553:b0:5ce:dddf:fc9b with SMTP id
 4fb4d7f45d1cf-5cedddffd4fmr840428a12.4.1730715074489; Mon, 04 Nov 2024
 02:11:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101184309.231941-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241101184309.231941-1-alexandre.ferrieux@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 11:11:03 +0100
Message-ID: <CANn89iKiEe4rwq0uPKBqWdQvM6RvRmw=zfMXhzXN9t7iGVgy-A@mail.gmail.com>
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: alexandre.ferrieux@orange.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:43=E2=80=AFPM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a strucured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
>
>   tc filter add dev myve $FILTER1
>   tc filter add dev myve $FILTER2
>   for i in {1..2048}
>   do
>     echo $i
>     tc filter del dev myve $FILTER2
>     tc filter add dev myve $FILTER2
>   done
>
> This patch adds the missing decoding logic for handles that
> deserve it.
>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> ---


$ scripts/get_maintainer.pl net/sched/cls_u32.c

->

Jamal Hadi Salim <jhs@mojatatu.com> (maintainer:TC subsystem)
Cong Wang <xiyou.wangcong@gmail.com> (maintainer:TC subsystem)
Jiri Pirko <jiri@resnulli.us> (maintainer:TC subsystem)

Please resend adding them to get their feedback ?

Thank you.

>  net/sched/cls_u32.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 9412d88a99bc..54b5fca623da 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -41,6 +41,16 @@
>  #include <linux/idr.h>
>  #include <net/tc_wrapper.h>
>
> +static inline unsigned int handle2id(unsigned int h)
> +{
> +       return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
> +}
> +
> +static inline unsigned int id2handle(unsigned int id)
> +{
> +       return (id | 0x800U) << 20;
> +}
> +
>  struct tc_u_knode {
>         struct tc_u_knode __rcu *next;
>         u32                     handle;
> @@ -310,7 +320,7 @@ static u32 gen_new_htid(struct tc_u_common *tp_c, str=
uct tc_u_hnode *ptr)
>         int id =3D idr_alloc_cyclic(&tp_c->handle_idr, ptr, 1, 0x7FF, GFP=
_KERNEL);
>         if (id < 0)
>                 return 0;
> -       return (id | 0x800U) << 20;
> +       return id2handle(id);
>  }
>
>  static struct hlist_head *tc_u_common_hash;
> @@ -360,7 +370,7 @@ static int u32_init(struct tcf_proto *tp)
>                 return -ENOBUFS;
>
>         refcount_set(&root_ht->refcnt, 1);
> -       root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : 0x800000=
00;
> +       root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : id2handl=
e(0);
>         root_ht->prio =3D tp->prio;
>         root_ht->is_root =3D true;
>         idr_init(&root_ht->handle_idr);
> @@ -612,7 +622,7 @@ static int u32_destroy_hnode(struct tcf_proto *tp, st=
ruct tc_u_hnode *ht,
>                 if (phn =3D=3D ht) {
>                         u32_clear_hw_hnode(tp, ht, extack);
>                         idr_destroy(&ht->handle_idr);
> -                       idr_remove(&tp_c->handle_idr, ht->handle);
> +                       idr_remove(&tp_c->handle_idr, handle2id(ht->handl=
e));
>                         RCU_INIT_POINTER(*hn, ht->next);
>                         kfree_rcu(ht, rcu);
>                         return 0;
> @@ -989,7 +999,7 @@ static int u32_change(struct net *net, struct sk_buff=
 *in_skb,
>
>                 err =3D u32_replace_hw_hnode(tp, ht, userflags, extack);
>                 if (err) {
> -                       idr_remove(&tp_c->handle_idr, handle);
> +                       idr_remove(&tp_c->handle_idr, handle2id(handle));
>                         kfree(ht);
>                         return err;
>                 }
> --
> 2.30.2
>

