Return-Path: <netdev+bounces-143154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A975D9C145E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8841C20C24
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85AB61FFE;
	Fri,  8 Nov 2024 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx5Qt9Kk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14182EBE;
	Fri,  8 Nov 2024 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034741; cv=none; b=Brer//F6/wRedSM/etdrjC6AL6GNGYiEVoz+le7WfdeutpmTRgPZNy+jl0EMmELSyn5XZ4HNTkZhKHu1bMO2dA/aAwZlgH05VbX8qYEa0kKlf32M2XXRexpJid864DX4R7ry8qWwrYHiQ4iErzX8KHT9m4SOlp916hFU7tC7amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034741; c=relaxed/simple;
	bh=tRZ7fxX3EwqHdfj3f1R1i/RsvvPXOEkO1pWrqgEXLB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ9Xf/pEexTtHjLa6YtPT/ukgIdYyy3VHSocjrWsvyu6Wp4VaouzEi0DaoasBn8/CAsBbJ8FTzzY38wXAf2/nguIG0/91ZGhzE1YMUCnlCrVhRswuDem3Df+A/geqfWdT4Xg3U4brsltWXFVtAHx9gwDUS9ie7eX52S8sNOk3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx5Qt9Kk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso1504076b3a.0;
        Thu, 07 Nov 2024 18:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731034739; x=1731639539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0f9JGD6wOnVfB998AmyogDG6xLd5lbAbYBvJQf2ilWc=;
        b=cx5Qt9Kkse52PxM2Gpo7yM5195bg+ZNI7momkirylUUlAF34z9bduihm2rW5NZCuAi
         1gbB9JZuF/5zDl1Of2k3eNlqC5kqi5nSC13aa2SjwYfaisIDz1FR4Nionb4WADdZzDtd
         J87rzfykVEJbhCiWh3NDzxV6wJv21RKzG5f2+HmHGQo/H0UMs3Z3+YJje9jvWN/eJ1IS
         1d6meV1eRroyE42AlA+/BoxXBy1jjyXpnXZkJTE+I6o0leOjvhj9QVO0j1wPm30btv3I
         TnHDqsi5WDwcPoZZs8BBropjO9q+lyZZUXcadLCLK80OuLqv95KGi8b5ScT5QoDhR35E
         J9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034739; x=1731639539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0f9JGD6wOnVfB998AmyogDG6xLd5lbAbYBvJQf2ilWc=;
        b=keN6DSPw7O0Am0NXNhQXlpYAiqK/jCANDSXV0NTED7L4mo8zylb7OKCLLKzEl6b0+4
         +ALhoUC/PaT2OTCTg8xcOFDvdHFetenNL/kKRYno4tRCg8liCLXSmrig8/8N+9bHC5XW
         DuZm8VkO4PoeDK47+/llkaMdhPKrwo6ghZq9KbHoaMKi8JN5Ha2x104KZjoctrJYDaUr
         G8a3239Vnme2ge2pjsYOfG5JsYwKIHyf5tVXDJU04GW3mPJY4ESzfvsvFo4SiQqcItkq
         Z/ncKGcRyMP1C3c+Cdlq+U/2g4h3xQhie+6+Vnog1WvqpQN1Yyh9iRFpUMgR6SHXqH8X
         CsBw==
X-Forwarded-Encrypted: i=1; AJvYcCWJIAA940rQWSi/5wPHeOOAmQRsplpXsgVJ7InPzpZ+mu9t7vujVtaRcyt9WIJAjhWWdW28gnYE+5droYTk@vger.kernel.org, AJvYcCX9nAEw7PxI2Ghi664V+UlFKfnw7zgup3KWJmoqMTlXsADCYJL+sl+It1yOPZzyXT/jJjLM4+ZVaw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwscU1qGIo3GhryTJRw+nkgXQu4EPHOoY40onr9K4gmv+3BO2L
	zM2TIjIsxi0q3jicaLp8G3Qm5kwQvK7HxRMPwiDyIr63ZOPNAPg=
X-Google-Smtp-Source: AGHT+IE04/+gzIlxJwNcWWdcGtC+mO+YD+rnmYpZYO4PVvt1i//KBzsrv8RTCdy+qpLgEMROfoVsQw==
X-Received: by 2002:a05:6300:7105:b0:1db:e3f1:320b with SMTP id adf61e73a8af0-1dc22a60d6cmr1106125637.26.1731034739199;
        Thu, 07 Nov 2024 18:58:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785f8c6sm2499175b3a.35.2024.11.07.18.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:58:58 -0800 (PST)
Date: Thu, 7 Nov 2024 18:58:57 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Yi Lai <yi1.lai@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net v2 1/2] net: fix SO_DEVMEM_DONTNEED looping too long
Message-ID: <Zy1-cUvWqGKdjltE@mini-arch>
References: <20241107210331.3044434-1-almasrymina@google.com>
 <Zy1pT_VcNpFoGjq-@mini-arch>
 <CAHS8izMOtG4UVJNO2Dd-Zcn3aRL_LZFBzTRXn+xa+W_DGzju4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMOtG4UVJNO2Dd-Zcn3aRL_LZFBzTRXn+xa+W_DGzju4Q@mail.gmail.com>

On 11/07, Mina Almasry wrote:
> On Thu, Nov 7, 2024 at 5:28 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 11/07, Mina Almasry wrote:
> > > Exit early if we're freeing more than 1024 frags, to prevent
> > > looping too long.
> > >
> > > Also minor code cleanups:
> > > - Flip checks to reduce indentation.
> > > - Use sizeof(*tokens) everywhere for consistentcy.
> > >
> > > Cc: Yi Lai <yi1.lai@linux.intel.com>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > v2:
> > > - Retain token check to prevent allocation of too much memory.
> > > - Exit early instead of pre-checking in a loop so that we don't penalize
> > >   well behaved applications (sdf)
> > >
> > > ---
> > >  net/core/sock.c | 42 ++++++++++++++++++++++++------------------
> > >  1 file changed, 24 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 039be95c40cf..da50df485090 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1052,32 +1052,34 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
> > >
> > >  #ifdef CONFIG_PAGE_POOL
> > >
> > > -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
> > > - * 1 syscall. The limit exists to limit the amount of memory the kernel
> > > - * allocates to copy these tokens.
> > > +/* This is the number of tokens and frags that the user can SO_DEVMEM_DONTNEED
> > > + * in 1 syscall. The limit exists to limit the amount of memory the kernel
> > > + * allocates to copy these tokens, and to prevent looping over the frags for
> > > + * too long.
> > >   */
> > >  #define MAX_DONTNEED_TOKENS 128
> > > +#define MAX_DONTNEED_FRAGS 1024
> > >
> > >  static noinline_for_stack int
> > >  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > >  {
> > >       unsigned int num_tokens, i, j, k, netmem_num = 0;
> > >       struct dmabuf_token *tokens;
> > > +     int ret = 0, num_frags = 0;
> > >       netmem_ref netmems[16];
> > > -     int ret = 0;
> > >
> > >       if (!sk_is_tcp(sk))
> > >               return -EBADF;
> > >
> > > -     if (optlen % sizeof(struct dmabuf_token) ||
> > > +     if (optlen % sizeof(*tokens) ||
> > >           optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > >               return -EINVAL;
> > >
> >
> > [..]
> >
> > > -     tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> >
> > Oh, so we currently allocate optlen*8? This is a sneaky fix :-p
> >
> > > +     num_tokens = optlen / sizeof(*tokens);
> > > +     tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
> > >       if (!tokens)
> > >               return -ENOMEM;
> > >
> > > -     num_tokens = optlen / sizeof(struct dmabuf_token);
> > >       if (copy_from_sockptr(tokens, optval, optlen)) {
> > >               kvfree(tokens);
> > >               return -EFAULT;
> > > @@ -1086,24 +1088,28 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > >       xa_lock_bh(&sk->sk_user_frags);
> > >       for (i = 0; i < num_tokens; i++) {
> > >               for (j = 0; j < tokens[i].token_count; j++) {
> >
> > [..]
> >
> > > +                     if (++num_frags > MAX_DONTNEED_FRAGS)
> > > +                             goto frag_limit_reached;
> > > +
> >
> > nit: maybe reuse existing ret (and rename it to num_frags) instead of
> > introducing new num_frags? Both variables now seem to track the same
> > number.
> 
> I almost sent it this way, but I think that would be wrong.
> 
> num_frags is all the frags inspected.
> ret is all the frags freed.
> 
> The difference is subtle but critical. We want to exit when we've
> inspected 1024 frags, not when we've freed 1024 frags, because the
> user may make us loop forever if they ask us to free 10000000 frags of
> which none exist.

I see. Maybe can mitigate the damage with the following:

for (i = 0; i < min(num_tokens, MAX_DONTNEED_FRAGS); i++)
	for (j = 0; j < min(tokens[i].token_count, MAX_DONTNEED_FRAGS); j++)

In this case, worst case, we loop 1024*1024 on the invalid input :-D
But up to you, separate num_frag works as well (but, as you've seen with
my initial reply, it's not super straightforward).

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

