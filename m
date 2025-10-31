Return-Path: <netdev+bounces-234651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52507C25297
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DECC4262E4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC33446DD;
	Fri, 31 Oct 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGWTOgvT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F12E6CA8
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915901; cv=none; b=TPLp1DocxMvXGDHF8xDVbWxLmRFUgShiLKPK4XOLYcoPkeJJ4b3mKS+vlLcyb8ZBT8h8qlBq++lDYMdQOpWdY+nabZxLZR30ZOmHonroUh2xUEGR0XnL9OtONWFDpQ2A7+aJnTo8HQK2cBinWdnjjn4SFdZpLbPULPsB0mgoEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915901; c=relaxed/simple;
	bh=ZXkLDTr8nSCVJ26GqbMBd9kDRvIEMx/HbigcYuaDpnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At3QlfTsvejExOo5iBdcodRM/N1wI6TGTpRhkEeIyGOT7MDSNqEionqGB0AqJI2OOJ6wZ5ByPzany1DFKclFcd7uVebFszqyvB8anmD55/i4rQRWEEzStiFB8iKVFgQMQTnmvvLTzUiJU9V261yNsq6KD50f6fkI7RbHkIAoAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGWTOgvT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ecf03363c9so16513721cf.1
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761915898; x=1762520698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDiDynQdbM4YCkifi3qZwLvI//rX+qgG18kLYdtT/4E=;
        b=zGWTOgvTB3D/F66yiJp5yMOyuYmT3GOWJK09pjy7HAD27axObslNoBdhL+1clNj2iE
         no2NH/+gS2aW5AuBgoXJNVx5f7OeCaeGtaa93ET/ggb5vdTnEyu18YGIkhFPkkhcVwdV
         5Gd+uB8RZolTTjthq8iiA9r8xfuIMbXNlRvPmP/CF5g6qDmJUNX/WY98mBwuGxe4y2Bn
         jEZ0G6AUEeZIJTxsm+xXcrtygNWhxhsUgfUnNe8iQ5ya2LwRnpTCN2M+dk/l9+1nsJ35
         x2BScEfgyc5PqcAA4u5Fdv3XoR9gfS3LhHtDvyCq2lobQ3aAKu7ni1bgtHeZs5p3QVzg
         8SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915898; x=1762520698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDiDynQdbM4YCkifi3qZwLvI//rX+qgG18kLYdtT/4E=;
        b=h2r+UPsQrmmlsG3Pu0PS6NgfPg0bSib8DtWsw5IznRUNiG5PJCsOTRljy3tNOSaA1e
         DkZKDWtlYwOhHg0R5Y9Y9Zsy804gEZgI+RJ90aB9FBh4azXydRvCvoaeFBTnccP6w/4S
         y5It4UTI1jodIQizp0ePEMSjZHmuG4Iv/YJZbHfCUISTospKWxXPTquxfC7DtPXuodX6
         HfTcDHWN89Xdkz4wVlZwjyuSyAV+CrZLZmkrfIUB7ahy+IANmtI4M3zGI7a9jbIWDrVD
         rd+dFWwioygF/0aaERtsbCcR/QlI/ATaPPZEfly3+k2KLsNSFzxncLQwbmYZ8ltQB6M/
         KiYA==
X-Forwarded-Encrypted: i=1; AJvYcCVvnn6i/oxJOHKcyW2Coi0qGwxv9l4OnYsXxVOyaIUr+1qgsuyMyO0H5qwj8GofD1b0amPnudY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZjldG089YkNiKNuYSdy9S1/m+ifMOPI7p55ZsLoouW4SiQqu
	au45irXHPo3ZBi7s4b6Yut4x+H1dI6H4sp8vbiMHNKPYg1wTWOrjGvzrbv6uM0TpxlWydfmY1P7
	vCdNd/JXtoK+Of5v59DlQhjxwjdj3uGceK5VmrLN2
X-Gm-Gg: ASbGncsd8bT/N3IMFpZp6Y2DDx+sDGplFpi/unoPc7UaqzvKOwW63F1gHP0rUretnAk
	ALHHFCDOXIuCg/pUm3eOE5yYSX+qko70oXpD5A4Z5yf4EdHhWBppyX5Mpe6KwRunpsHsM4kabqS
	b6MnaHWgWX+JcsQB4BR3AaEcjmGnvmTW1DukReovPJZhqji37lG6rj6eM5J5D5Tv7CXBgs2AXo1
	+dsYlekwDN5JL3kKq/BVfvZm+Hyh/COzcY7d2jpM4fS69f2mQY/Y3G4AEODkeP5od/YkI8=
X-Google-Smtp-Source: AGHT+IHegrj0d0o9bzyKTvokwzDp4oyCK2YZvXyBZt7oa/GcTr6PrpKIl05o7IhuEsdDpdFZDAMZ3HEW+TjxbJ0bK34=
X-Received: by 2002:a05:622a:4106:b0:4eb:9d8d:2f24 with SMTP id
 d75a77b69052e-4ed30f9c8camr40022091cf.40.1761915898124; Fri, 31 Oct 2025
 06:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-infoleak-v1-1-9f7250ee33aa@gmail.com>
In-Reply-To: <20251031-infoleak-v1-1-9f7250ee33aa@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Oct 2025 06:04:45 -0700
X-Gm-Features: AWmQ_bnXpmkVe3zJAzdYr8G9bxgCyUuK6HP9RyRDjUsMT-RKlpN9aPLHRuGIsyc
Message-ID: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
Subject: Re: [PATCH] net: sched: act_ife: initialize struct tc_ife to fix
 KMSAN kernel-infoleak
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 5:24=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
>
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
>
> This change silences the KMSAN report and prevents potential information
> leaks from the kernel memory.
>
> This fix has been tested and validated by syzbot. This patch closes the
> bug reported at the following syzkaller link and ensures no infoleak.
>
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Fixes: ef6980b6becb ("introduce IFE action")
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
>
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
> ---
>  net/sched/act_ife.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 107c6d83dc5c..608ef6cc2224 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -644,13 +644,16 @@ static int tcf_ife_dump(struct sk_buff *skb, struct=
 tc_action *a, int bind,
>         unsigned char *b =3D skb_tail_pointer(skb);
>         struct tcf_ife_info *ife =3D to_ife(a);
>         struct tcf_ife_params *p;
> -       struct tc_ife opt =3D {
> -               .index =3D ife->tcf_index,
> -               .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> -               .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> -       };
> +       struct tc_ife opt;
>         struct tcf_t t;
>
> +       memset(&opt, 0, sizeof(opt));
> +       memset(&t, 0, sizeof(t));

Why is the second memset() needed ? Please do not add unrelated changes.

Also I would also fix tcf_connmark_dump()

> +
> +       opt.index =3D ife->tcf_index,
> +       opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> +       opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> +
>         spin_lock_bh(&ife->tcf_lock);
>         opt.action =3D ife->tcf_action;
>         p =3D rcu_dereference_protected(ife->params,
>
> ---
> base-commit: d127176862a93c4b3216bda533d2bee170af5e71
> change-id: 20251031-infoleak-8a7de6afc987
>
> Best regards,
> --
> Ranganath V N <vnranganath.20@gmail.com>
>

