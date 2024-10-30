Return-Path: <netdev+bounces-140426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738479B6650
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEAB1F217FD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E754A1F12E5;
	Wed, 30 Oct 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HadkQECS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1BC26AD4
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299616; cv=none; b=Gam9oCYQBcFFfJ0GPLzlEU+NVWcL7OqTkl+Pwwq6G8JnSmhkoB2ADk4sg5z9EfyaWRzn1RZn8s+PLvgc3Mi9HFe/l9SSJWThBkfefZTCjpk72B2EmdIkZ9AOzN3XSUgWFKOwRCgOZdV2p/b1DN0bnnSm0Ze4nP6zjaLTB6W/fgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299616; c=relaxed/simple;
	bh=NhwqWyY/+B3HNQ4Zf0F1u8UUhwHCc0U85k9UaImZi+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pP0sEtP8hGgofTYeO1pvM/LgokIswj5cBQYvNwQ3JWXLWHSgv/g18oUtOfbuPI7YDDJxj0AjMNP3+6CBDomyFGJBM6INGE4eN2zcmyG0apuY0hoV18renZ3+vTl3PaQsaYvNyGni7wWeeyj9TO2+sN9F43V6dOIwzxEFu+lomgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HadkQECS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460b295b9eeso282751cf.1
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730299613; x=1730904413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuDgcDjnMSaWBwmR/hE5gS6R3pwsgWNYwLcvCI/5raw=;
        b=HadkQECSYCRg/8LnumacTNk/raXMe1BUBkRjAqiIFZ3LhYHdla5lW61+hqMppRlVtu
         1zMqviiRosPfa83lGeiIQjtpmRcVDpmn1GcHoxIHJ6JuRhw5SaZB+TP93BW7sPSHgjWL
         zFEaLbQHGz2shOu+6R8HLkoYV4EYkDc5knGeAs4bKIPPyygsbG5/93BYDvsHlvz/RUyw
         bkwMSAW71rxHxX8/UKDtgq/QjcZicrXdFc6H9TKfEblOWUqLfB6cQ+YbG1OUJ36yuikZ
         aQc/Ns/dhOBPx7gwuhlwSfPKx4fJRYNESaq6ECRiKNbdf1ZECi+axbipF3mXQPkxKF2H
         Reig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299613; x=1730904413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuDgcDjnMSaWBwmR/hE5gS6R3pwsgWNYwLcvCI/5raw=;
        b=Qa4Fropb4n0VixY7z/62V0x2DMTfM848xaV4a/H2Vc8SOkkV39Nr30VHqjnT82P63v
         S/UL41GYK06I+u5ep1DU35F4wyw2KOxpkJk8s/+y70Yu/qVtofRVB8xZgid36oV8iDaE
         FbR++ZkHewStz8fUhnE3WPQd2p9oQVhS3VMX+WQsLQ59pIzvhMVTilbnZLtkf/nvw50Q
         72z8PWV3PuTnOvTpDQtlKpSZ3iL63J4ruDu8pQaLBuZ69u70qgoRm64i8s4JQlG3+T7/
         ZeO0M3EWcyLwZYcTAwSwGYkVbVQwvor7ejskNf002HxW1Vo9THv6DtVw8KX/527hcf6w
         MPRg==
X-Gm-Message-State: AOJu0YywDAw37n8lmu/0/sUM/ljau1AQ78Zgd7ff7CLC09dAGC1nQw5u
	jU1w0tkYcBArg/d38pFdsiwt86k46LRIU6BIZejEwto3IxfLI52gn3BDyfo50xavYD/4G6mtTUO
	9VVyKoKSbBj5wY8eg8Bi1oFEfe5+zA5krlq5z
X-Gm-Gg: ASbGncvXSAMBWMrnelR6wFnFNU9OWUyHgcjWtAZzTM7v2yiAtYwMQzRSrlfbiFzzacr
	gar/G5akn+NGc6424c78xqUspjH72MzM=
X-Google-Smtp-Source: AGHT+IHO71Bgm3DP3V5XUI+nKDL6o15iOeRQ0hNxysL/MW5H5VlmppL+MsAbA04+c6Sv5xzLC92i8Rvoo7uv21QiiBM=
X-Received: by 2002:ac8:7d55:0:b0:460:3f4a:40a1 with SMTP id
 d75a77b69052e-46166dc4566mr8035791cf.13.1730299613385; Wed, 30 Oct 2024
 07:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com>
 <20241029205524.1306364-2-almasrymina@google.com> <ZyJDxK5stZ_RF71O@mini-arch>
In-Reply-To: <ZyJDxK5stZ_RF71O@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 30 Oct 2024 07:46:41 -0700
Message-ID: <CAHS8izNKbQHFAHm2Sz=bwwO_A0S_dOLNDff7GTSM=tJiJD2m0A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 6/7] net: fix SO_DEVMEM_DONTNEED looping too long
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Yi Lai <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 7:33=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/29, Mina Almasry wrote:
> > Check we're going to free a reasonable number of frags in token_count
> > before starting the loop, to prevent looping too long.
> >
> > Also minor code cleanups:
> > - Flip checks to reduce indentation.
> > - Use sizeof(*tokens) everywhere for consistentcy.
> >
> > Cc: Yi Lai <yi1.lai@linux.intel.com>
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  net/core/sock.c | 46 ++++++++++++++++++++++++++++------------------
> >  1 file changed, 28 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 7f398bd07fb7..8603b8d87f2e 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1047,11 +1047,12 @@ static int sock_reserve_memory(struct sock *sk,=
 int bytes)
> >
> >  #ifdef CONFIG_PAGE_POOL
> >
> > -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED i=
n
> > +/* This is the number of frags that the user can SO_DEVMEM_DONTNEED in
> >   * 1 syscall. The limit exists to limit the amount of memory the kerne=
l
> > - * allocates to copy these tokens.
> > + * allocates to copy these tokens, and to prevent looping over the fra=
gs for
> > + * too long.
> >   */
> > -#define MAX_DONTNEED_TOKENS 128
> > +#define MAX_DONTNEED_FRAGS 1024
> >
> >  static noinline_for_stack int
> >  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int o=
ptlen)
> > @@ -1059,43 +1060,52 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t=
 optval, unsigned int optlen)
> >       unsigned int num_tokens, i, j, k, netmem_num =3D 0;
> >       struct dmabuf_token *tokens;
> >       netmem_ref netmems[16];
> > +     u64 num_frags =3D 0;
> >       int ret =3D 0;
> >
> >       if (!sk_is_tcp(sk))
> >               return -EBADF;
> >
> > -     if (optlen % sizeof(struct dmabuf_token) ||
> > -         optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > +     if (optlen % sizeof(*tokens) ||
> > +         optlen > sizeof(*tokens) * MAX_DONTNEED_FRAGS)
> >               return -EINVAL;
> >
> > -     tokens =3D kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> > +     num_tokens =3D optlen / sizeof(*tokens);
> > +     tokens =3D kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL=
);
> >       if (!tokens)
> >               return -ENOMEM;
> >
> > -     num_tokens =3D optlen / sizeof(struct dmabuf_token);
> >       if (copy_from_sockptr(tokens, optval, optlen)) {
> >               kvfree(tokens);
> >               return -EFAULT;
> >       }
> >
> > +     for (i =3D 0; i < num_tokens; i++) {
> > +             num_frags +=3D tokens[i].token_count;
> > +             if (num_frags > MAX_DONTNEED_FRAGS) {
> > +                     kvfree(tokens);
> > +                     return -E2BIG;
> > +             }
> > +     }
> > +
> >       xa_lock_bh(&sk->sk_user_frags);
> >       for (i =3D 0; i < num_tokens; i++) {
> >               for (j =3D 0; j < tokens[i].token_count; j++) {
> >                       netmem_ref netmem =3D (__force netmem_ref)__xa_er=
ase(
> >                               &sk->sk_user_frags, tokens[i].token_start=
 + j);
> >
> > -                     if (netmem &&
> > -                         !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
> > -                             netmems[netmem_num++] =3D netmem;
> > -                             if (netmem_num =3D=3D ARRAY_SIZE(netmems)=
) {
> > -                                     xa_unlock_bh(&sk->sk_user_frags);
> > -                                     for (k =3D 0; k < netmem_num; k++=
)
> > -                                             WARN_ON_ONCE(!napi_pp_put=
_page(netmems[k]));
> > -                                     netmem_num =3D 0;
> > -                                     xa_lock_bh(&sk->sk_user_frags);
> > -                             }
> > -                             ret++;
>
> [..]
>
> > +                     if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(ne=
tmem)))
> > +                             continue;
>
> Any reason we are not returning explicit error to the callers here?
> That probably needs some mechanism to signal which particular one failed
> so the users can restart?

Only because I can't think of a simple way to return an array of frags
failed to DONTNEED to the user.

Also, this error should be extremely rare or never hit really. I don't
know how we end up not finding a netmem here or the netmem is page.
The only way is if the user is malicious (messing with the token ids
passed to the kernel) or if a kernel bug is happening.

Also, the information is useless to the user. If the user sees 'frag
128 failed to free'. There is nothing really the user can do to
recover at runtime. Only usefulness that could come is for the user to
log the error. We already WARN_ON_ONCE on the error the user would not
be able to trigger.

--=20
Thanks,
Mina

