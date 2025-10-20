Return-Path: <netdev+bounces-230794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8D1BEF925
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCB054EEBB4
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094F189F3B;
	Mon, 20 Oct 2025 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhG5fBrn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72222173F
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943746; cv=none; b=P0noWNr+EerJe59ouidE6wD6wVjTzUBthJ+1Uam6xkWo7iJeGsJqJbGqDhf5o6MEfirt72k9diQVw3wZKOksJf2R43R9J4q8WbgqUfewPezWo9odbzvVXGNt4snmGnUmR5spIX9xXHeYNX4twdRTrfdW8fAoNAmVVUcnOxSbN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943746; c=relaxed/simple;
	bh=PzcCWALgeN9cP5fqbEESC/ispkDazn4fIzXsdseXios=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vb0uotbVbB52b2/2wF7iz2JKsVNmtXwztSIPje0sjMfHWe1Wlyt+NgVHVi/iOQeKhGZ1stY7Jly9aHBrwcihk0VdxqqwEJntyNEHC5a65DH9V9YG1CMNFuYXYrdP/ddZ1HIVJCop8x1xvKQTh3VGl0s5J4XPaHABR1mNRSUEdOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhG5fBrn; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430d0cad0deso8297475ab.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760943743; x=1761548543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3DLhKzyK3Qvu7YdNftDnNGumEF9nA9T8bRsVdS0bTA=;
        b=BhG5fBrn1x7XiBSStrw+8fQstleihIwZ2qsi8YSs+hfYAcIm2R0YZJmQioZTfmx4ST
         cPKS+29uGYWe8E0Khd49omjWjMNZtdQLmOk578iMEapMosGEbkMUHaNdVoIAs44d2kjr
         9AYJR1k+LCGrAl061KyDW4X9RFGlRkWE4UeuCmPfwKhWe+2yQPg7yunbfHIrbvW86wKV
         To/hbNdPiQSggHtbH9xwRWspOfSPm9ryrwk/QfSluA/rceEqgZyfvHq4SkfSv8cn2P/I
         Rm3cGL5Y83zBgt7ysajOkS8QvRm2AV4gtSsw3sigs10NLVoq6QLEAj8yb8toLFQwuQS3
         bwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760943743; x=1761548543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3DLhKzyK3Qvu7YdNftDnNGumEF9nA9T8bRsVdS0bTA=;
        b=LVPbWJqjRRUUOd/BFMycD7GdtIxN+jKW41ZI5zfWu9LE9GwDk/nvs8olx05y06a1cd
         li4pEi+jyv71TYhGoeKzWFw7ZJ8vsOKN8+gLxeW/DKLd4702WG2/riJWR/lCERUfT1pX
         0YxCLcPngDiBL3yhaADp+tuVCkyHX9KgIqAnCPzGj/s+dZhvt+2xn7+smoGq2ehiZYlq
         b2oh7g6CtrSSoNVaF9j1zWrF8MikR2nra2uSJwZ8jZ6tej4U83SYcuotIlM1kQKFdriD
         xq9Q7cXanS0qzjWMueVExisNapuS7nQerjXpejTzJ+f/8oKfD/USLu/OW6YqEYQcv6H5
         HgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVUNTpGDQ2EspvH3ie2QSXgIRin/Ekduen6zIWvc03BQp4H9E2RlGTRAoZNUkkacut4t7sxhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHMSl9piYtr0hml5hiYWRZnlO4WKA8P6X+SvlaUz9QD1c3S2E
	1kyt+f4we2FayIBJqxWtEbRipRg3OkDKkvD++OeCT5qzWfDMpLafQk1sKYCR10ceqZgc/uw9WKN
	1tqDyzsVNySmqWH5gLjtw+17a0OAJSEw=
X-Gm-Gg: ASbGncsUr2yj62up0ONVYzWVc8B6oiKpsYpNhiQd/kluxgKnKKsufD2PagrST5CYage
	GHOJ4440bTSLoOXs8ScHLv7BNHC23rNWWGL0HKMJVJ2crHfZgdP+99T82AUNQ1FHvcIqZsJCu8V
	fquKl6skDI0VFFhxeaZgZl9aAsPmJ5+WJqpBQydnShhgpsjedpCrZzgN2Kxz93GuzpW/WCWHMTU
	2jYWGdbiTDZSVtdW+5RLMJgXJTUeNaJKsC1zGOfBzRItHubJpmh2H6Ikbpk
X-Google-Smtp-Source: AGHT+IGy3gEa+loIOXHh8F7+H9LA9TygWtWlDgCNyUFBls73j98A6LSxMxicFTkKsi98TCiyN0lL3sTCbblvwYeF/Xo=
X-Received: by 2002:a05:6e02:3e04:b0:425:8744:de7d with SMTP id
 e9e14a558f8ab-430c5292336mr180038105ab.30.1760943743166; Mon, 20 Oct 2025
 00:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com> <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com> <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
In-Reply-To: <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Oct 2025 15:01:46 +0800
X-Gm-Features: AS18NWD9jU_k0Ed6QKwG7Bm3zPDN4V_D-UWmWcM66gun2HnhvXe4ijMLJzkrqgg
Message-ID: <CAL+tcoD6+0gSMS2rOiOOFpnJ=iyYYJuNMg8+mNXBqCOYyeo5uw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:46=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Oct 15, 2025 at 5:30=E2=80=AFAM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Wed, 15 Oct 2025 05:16:05 -0700
> >
> > > On Wed, Oct 15, 2025 at 5:02=E2=80=AFAM Alexander Lobakin
> > > <aleksander.lobakin@intel.com> wrote:
> > >>
> > >> From: Eric Dumazet <edumazet@google.com>
> > >> Date: Tue, 14 Oct 2025 17:19:03 +0000
> > >>
> > >>> While stress testing UDP senders on a host with expensive indirect
> > >>> calls, I found cpus processing TX completions where showing
> > >>> a very high cost (20%) in sock_wfree() due to
> > >>> CONFIG_MITIGATION_RETPOLINE=3Dy.
> > >>>
> > >>> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() m=
acro.
> > >>>
> > >>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >>> ---
> > >>>  net/core/skbuff.c | 11 ++++++++++-
> > >>>  1 file changed, 10 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > >>> index bc12790017b0..692e3a70e75e 100644
> > >>> --- a/net/core/skbuff.c
> > >>> +++ b/net/core/skbuff.c
> > >>> @@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *=
skb)
> > >>>       skb_dst_drop(skb);
> > >>>       if (skb->destructor) {
> > >>>               DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> > >>> -             skb->destructor(skb);
> > >>> +#ifdef CONFIG_INET
> > >>> +             INDIRECT_CALL_3(skb->destructor,
> > >>> +                             tcp_wfree, __sock_wfree, sock_wfree,
> > >>> +                             skb);
> > >>> +#else
> > >>> +             INDIRECT_CALL_1(skb->destructor,
> > >>> +                             sock_wfree,
> > >>> +                             skb);
> > >>> +
> > >>> +#endif
> > >>
> > >> Is it just me or seems like you ignored the suggestion/discussion un=
der
> > >> v1 of this patch...
> > >>
> > >
> > > I did not. Please send a patch when you can demonstrate the differenc=
e.
> >
> > You "did not", but you didn't reply there, only sent v2 w/o any mention=
.
> >
> > >
> > > We are not going to add all the possible destructors unless there is =
evidence.
> >
> > There are numbers in the original discussion, you'd have noticed if you
> > did read.
> >
> > We only ask to add one more destructor which will help certain
> > perf-critical workloads. Add it to the end of the list, so that it won'=
t
> > hurt your optimization.
> >
> > "Send a patch" means you're now changing these lines now and then they
> > would be changed once again, why...
>
> I can not test what you propose.
>
> I can drop this patch instead, and keep it in Google kernels, (we had
> TCP support for years)
>
> Or... you can send a patch on top of it later.
>

Sorry, I've been away from the keyboard for a few days. I think it's
fair to let us (who are currently working on the xsk improvement) post
a simple patch based on the series.

Regarding what you mentioned that 1% is a noisy number, I disagree.
The overall numbers are improved, rather than only one or small part
of them. I've done a few tests under different servers, so I believe
what I've seen. BTW, xdpsock is the test tool that gives a stable
number especially when running on the physical machine.

@ Alexander I think I can post that patch with more test numbers and
your 'suggested-by' tag included if you have no objection:) Or if you
wish you could do it on your own, please feel free to send one then :)

Thanks,
Jason

