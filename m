Return-Path: <netdev+bounces-143135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363BF9C13AD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F380B21E46
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082F15E96;
	Fri,  8 Nov 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pklwxi4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1EDDDC3
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029631; cv=none; b=odjQ1Bnm/buWrHZqlLy7HQMS9oCDu1Whh5INvx0uQnl9ts1d7Vy4Sgq01IcYhWJL+R/fvn/wltc4QXW9v0DjRW+KJ83Vk5+0LuT871494fPcMRCe1CEjDtKQBOSQKG4YjVuG3OpzTfKpNHDd0hP4qAgdrNbYXGf9rEWSbngZOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029631; c=relaxed/simple;
	bh=0CIxROtxo9lkntRR5/pEgOmD4bfh0hD4R2SzeU4lydE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5XsYTpf6IAUU0g48ugicQO25ul8BGfDC29h/8I1ta7VT7JydkD8sZj7CspJhlUH/MXNK82VD40KgrkxxFES4t2dnwhA8FBAdn+x87oeyX1Yq4klKvkxDJZ0+uw8Kogrmux2P7gSxvCtgs9jL7VdVhXWg4tKuhWZa6YufyWbHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pklwxi4j; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460969c49f2so133721cf.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 17:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731029627; x=1731634427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzVdoP6OciidGt4pR8gTvT8j2Y8JEz3d7rgCHYOZPoQ=;
        b=pklwxi4jsIMY1E/BkMrQ0VlH/Cvp5i6LwAnUQgrMi5OvrSjLXv2ugB1ZqahVhI8MKz
         r56bgOrjawpH/0WOqzgB+OM19QIGyvc2RDpFo5RogTRajb0JrMpBJ4n/V35f+uHUWZft
         haDAfvWn1OmAjdWiRA0SjHB0v8xaPjsXacO337aG3jbvELJIvLxMk1BzhUVhFAfDERDj
         all7eNRqeFUpT27Na9vT+JH1wbLgZf303Z3OCuRvCroBeKrQ9oyvnrLhRiFuVaS68L3v
         EkfWU5XrIlM9XLjvfkeKDY9/W44UNwMMjT7MzSt71fDq8ykwtabgkwvzXcLqYJa3LC98
         2ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731029627; x=1731634427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzVdoP6OciidGt4pR8gTvT8j2Y8JEz3d7rgCHYOZPoQ=;
        b=q9HSD//s7VI5mnyJxpMONRfkuKfTMoYo9sezzCxhgC0NNAjibl4/bmMD8shj/fInwA
         SsS6ebZ3qvOaP6rhgvTeeem8vWt5SZW/hczcdfqODXFReRkjyj2VaF+ZFTFxLjhTo1CW
         pTG1eFzdaQPS4/aj327vO0Ns2AAT5l+r9aYZ5bxdglRT+Iiovcg8N4vo6CLvgD0GId3s
         hOmqEvwOOVU2/1LrfsvmwRqBjn1txdWv1D9ziGX4Zc+isWcWbg2zOYEjLKhwfNlQd8FD
         dVijTEtmz9VsuDLMPNndr7bAecbcVcgmm9PzIFJhRpMspalEnvgylNGo2to5BFJgEbu0
         BfzQ==
X-Gm-Message-State: AOJu0Yw6pfqukhhik+oug7o0LhCfSsZ7t+VY3KpCkqSvMR2TSqR79Ev8
	EquaLshRzChl8IxCLolT/hr/RDcW3UJfpVO7r+/7dOn2+edzLaJPm5u97ErTaV1Fo7Qqt7RT2fX
	+DKVhICvUte0NswtVQiIGA2CQ9gK8TQWL4uwE
X-Gm-Gg: ASbGncshw0/1rpGbU3Yx0COwL2q5rLI69wre55aVZwLT5j1dcAzhZfkljEfj0/s1Cob
	n86V4Na5JD5VA0Cf5FI0Pvfh6erivRxA=
X-Google-Smtp-Source: AGHT+IEvBJEp2/ytC5Ldt3ehz7w6UWY37/JOusDhlfa4YH7TdJ+scsvMtHFHwCI6X3S8loz7o4qaaWsBGgUSO4qjXec=
X-Received: by 2002:a05:622a:54c:b0:461:685d:324 with SMTP id
 d75a77b69052e-462fa59ee98mr7010221cf.16.1731029627085; Thu, 07 Nov 2024
 17:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107210331.3044434-1-almasrymina@google.com> <Zy1pT_VcNpFoGjq-@mini-arch>
In-Reply-To: <Zy1pT_VcNpFoGjq-@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Nov 2024 17:33:35 -0800
Message-ID: <CAHS8izMOtG4UVJNO2Dd-Zcn3aRL_LZFBzTRXn+xa+W_DGzju4Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: fix SO_DEVMEM_DONTNEED looping too long
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Yi Lai <yi1.lai@linux.intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:28=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 11/07, Mina Almasry wrote:
> > Exit early if we're freeing more than 1024 frags, to prevent
> > looping too long.
> >
> > Also minor code cleanups:
> > - Flip checks to reduce indentation.
> > - Use sizeof(*tokens) everywhere for consistentcy.
> >
> > Cc: Yi Lai <yi1.lai@linux.intel.com>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v2:
> > - Retain token check to prevent allocation of too much memory.
> > - Exit early instead of pre-checking in a loop so that we don't penaliz=
e
> >   well behaved applications (sdf)
> >
> > ---
> >  net/core/sock.c | 42 ++++++++++++++++++++++++------------------
> >  1 file changed, 24 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 039be95c40cf..da50df485090 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1052,32 +1052,34 @@ static int sock_reserve_memory(struct sock *sk,=
 int bytes)
> >
> >  #ifdef CONFIG_PAGE_POOL
> >
> > -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED i=
n
> > - * 1 syscall. The limit exists to limit the amount of memory the kerne=
l
> > - * allocates to copy these tokens.
> > +/* This is the number of tokens and frags that the user can SO_DEVMEM_=
DONTNEED
> > + * in 1 syscall. The limit exists to limit the amount of memory the ke=
rnel
> > + * allocates to copy these tokens, and to prevent looping over the fra=
gs for
> > + * too long.
> >   */
> >  #define MAX_DONTNEED_TOKENS 128
> > +#define MAX_DONTNEED_FRAGS 1024
> >
> >  static noinline_for_stack int
> >  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int o=
ptlen)
> >  {
> >       unsigned int num_tokens, i, j, k, netmem_num =3D 0;
> >       struct dmabuf_token *tokens;
> > +     int ret =3D 0, num_frags =3D 0;
> >       netmem_ref netmems[16];
> > -     int ret =3D 0;
> >
> >       if (!sk_is_tcp(sk))
> >               return -EBADF;
> >
> > -     if (optlen % sizeof(struct dmabuf_token) ||
> > +     if (optlen % sizeof(*tokens) ||
> >           optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> >               return -EINVAL;
> >
>
> [..]
>
> > -     tokens =3D kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
>
> Oh, so we currently allocate optlen*8? This is a sneaky fix :-p
>
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
> > @@ -1086,24 +1088,28 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t=
 optval, unsigned int optlen)
> >       xa_lock_bh(&sk->sk_user_frags);
> >       for (i =3D 0; i < num_tokens; i++) {
> >               for (j =3D 0; j < tokens[i].token_count; j++) {
>
> [..]
>
> > +                     if (++num_frags > MAX_DONTNEED_FRAGS)
> > +                             goto frag_limit_reached;
> > +
>
> nit: maybe reuse existing ret (and rename it to num_frags) instead of
> introducing new num_frags? Both variables now seem to track the same
> number.

I almost sent it this way, but I think that would be wrong.

num_frags is all the frags inspected.
ret is all the frags freed.

The difference is subtle but critical. We want to exit when we've
inspected 1024 frags, not when we've freed 1024 frags, because the
user may make us loop forever if they ask us to free 10000000 frags of
which none exist.

--=20
Thanks,
Mina

