Return-Path: <netdev+bounces-84563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D5897531
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653FD1F2AD56
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86714F9F5;
	Wed,  3 Apr 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4aFAUQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7414AD15
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161567; cv=none; b=Ee8rjAxvl2ecz50lwrshpwKFoyXvdBPk+Ebo+WtUwXsDCW/HPvgqM+sd0NXxIFgn0WIckC7wrbAsIuuNIhK4nHNk+KYkqE5HNcJyQUC6NbaCBZqR0o+toGqtKcYxYMibuvXS8V61Mn8PYHg3uZ/SwJn2dEMJ56Z+TqAPa8Ig1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161567; c=relaxed/simple;
	bh=zhJxyNy5k3KtJxDj4DMEzvEUSwEqQJMheR2fesgC7gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGDlQgnLVi54xqV4JC2/7AtjfbGX9Ex2wPL7U1jvBxI75iJvg8/imcNurV1dB9/WTvXy7a32noSL+y+d8Q/2U5qas/0tIJAC2jj98IsQrBJr9OOqgwh2BtRQjDKq+yXbaOafotEKdQ6GQDuSCOMdKi6y4RY/CP4eoP1QEFg4BUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4aFAUQn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso11120a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712161564; x=1712766364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC9+MUZ0hkQNiWKrPDkDuu75k6rlOuQC/LqJgmLBGzE=;
        b=L4aFAUQnsLdlLEJ/kZ7cA+wwroPRgLCkxh+dbR0OrAqpciynjEwizemUI3v5VEvtNI
         h5Lz8MzYUOR2QyHxkGtiSMaH29pkeu3MT4XZ6jk1aYGXXwRRhnlvR1ft4/ouI6xdjR2k
         QfI3lc58Dw5YSHYtgxBu5czTSB39CPil3u3/0tZp4SFT1ixt4kcjfdRiysZfPFLKAAgF
         ZLprfSZhwLxLxzF7ip21CUVHh4DYi6c8AjyJ7bgiixBbm+vAXi8akwIwDbpAGnwN8UOV
         E6SF9NLnKnSJkAsQBLoB/dwC2NaSz9ZGWCB8hof9h41XO3OSuuhTNc31/vZ/XUVRi6Le
         Yr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161564; x=1712766364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC9+MUZ0hkQNiWKrPDkDuu75k6rlOuQC/LqJgmLBGzE=;
        b=Z3ez6FdmbN0FFNbxOQIWW83cd+JrCZrVU3LZ6WVdsEqeFqT2Rzc8nxSc306ExMjCeY
         VR8j8NVzE8yq0O0bg2CsHaM1Uyx+UkpFzdyF2be83eqoHCM5gdaVUtoVw58vmtGX5Dsj
         InT2gM09amORGFix3mVXL2olfMx8NmRkg83REt1591hLTMVljXAX5sglHLzQ7q+Ee6Ay
         U7Um4xckEyd41656mGvHDguyA2Go/YDwJT9CBlIoAkU/Vqqyxc5AgB14n5gmjhF2bRmz
         SZBFvdHrluoMRrlGC212zsY6y7LEBxyHd3pnkfbK1J3qNw2UAmyLp489OXyO+gIgbAOn
         VB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc5d6E0ex/stz0otr42/XY+JRdjzqx3FgSyS3thJoWpeQel/odIcn3YzRemC387X/8x5sI1hlg6b+/aopm1gR78UUMrx5c
X-Gm-Message-State: AOJu0Yw6ncARzS1sH/Ghg1QOfhVAowJg5bdpgIUNw39EWcePqW1KRoLb
	Jq0K7RzdDyxOnhvtmX7NQ3xjs1SOKWEFGvgZ2HYlmgOb+ShuxJ/YW/OLoVnC4iKFcon5WEoxTo8
	oseg1A1vTH4fFm3JFJmgXhsK/AnXeYUGIMo5y
X-Google-Smtp-Source: AGHT+IHlKZgUEymdjETApeGkPw2l7XMhhkK5AxpUcQmQrygV0guizlQvTevQtKmD74Rli0TVy65RTwhcgE9QLW/VqqY=
X-Received: by 2002:aa7:df97:0:b0:56d:fdc5:b515 with SMTP id
 b23-20020aa7df97000000b0056dfdc5b515mr255661edy.4.1712161563747; Wed, 03 Apr
 2024 09:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403123913.4173904-1-edumazet@google.com> <67f5cb70-14a4-4455-8372-f039da2f15c2@kernel.org>
In-Reply-To: <67f5cb70-14a4-4455-8372-f039da2f15c2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 18:25:52 +0200
Message-ID: <CANn89iLQuN43FFHvSgLLY+2b-Yu2Uhy13tmrY_Q-8zX7zUcPkg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: remove RTNL protection from ip6addrlbl_dump()
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:13=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 4/3/24 6:39 AM, Eric Dumazet wrote:
> > diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
> > index 17ac45aa7194ce9c148ed95e14dd575d17feeb98..961e853543b64cd2060ef69=
3ae3ad32a44780aa1 100644
> > --- a/net/ipv6/addrlabel.c
> > +++ b/net/ipv6/addrlabel.c
> > @@ -234,7 +234,8 @@ static int __ip6addrlbl_add(struct net *net, struct=
 ip6addrlbl_entry *newp,
> >               hlist_add_head_rcu(&newp->list, &net->ipv6.ip6addrlbl_tab=
le.head);
> >  out:
> >       if (!ret)
> > -             net->ipv6.ip6addrlbl_table.seq++;
> > +             WRITE_ONCE(net->ipv6.ip6addrlbl_table.seq,
> > +                        net->ipv6.ip6addrlbl_table.seq + 1);
> >       return ret;
> >  }
> >
> > @@ -445,7 +446,7 @@ static void ip6addrlbl_putmsg(struct nlmsghdr *nlh,
> >  };
> >
> >  static int ip6addrlbl_fill(struct sk_buff *skb,
> > -                        struct ip6addrlbl_entry *p,
> > +                        const struct ip6addrlbl_entry *p,
> >                          u32 lseq,
> >                          u32 portid, u32 seq, int event,
> >                          unsigned int flags)
> > @@ -498,7 +499,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, str=
uct netlink_callback *cb)
> >       struct net *net =3D sock_net(skb->sk);
> >       struct ip6addrlbl_entry *p;
> >       int idx =3D 0, s_idx =3D cb->args[0];
> > -     int err;
> > +     int err =3D 0;
> >
> >       if (cb->strict_check) {
> >               err =3D ip6addrlbl_valid_dump_req(nlh, cb->extack);
> > @@ -510,7 +511,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, str=
uct netlink_callback *cb)
> >       hlist_for_each_entry_rcu(p, &net->ipv6.ip6addrlbl_table.head, lis=
t) {
> >               if (idx >=3D s_idx) {
> >                       err =3D ip6addrlbl_fill(skb, p,
> > -                                           net->ipv6.ip6addrlbl_table.=
seq,
> > +                                           READ_ONCE(net->ipv6.ip6addr=
lbl_table.seq),
>
> seems like this should be read once on entry, and the same value used
> for all iterations.

I thought of that, but this will miss any update done concurrently (if
all entries fit in a single skb)

It is unclear to me what user space can do with ifal_seq

There is no clear signal like :

Initial seq _before_ the dump, and seq seen _after_ the dump.

