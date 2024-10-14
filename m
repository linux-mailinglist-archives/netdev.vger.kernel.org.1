Return-Path: <netdev+bounces-135211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23299CCB6
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A601F23928
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568E01AAE37;
	Mon, 14 Oct 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggPcUWnc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981651AA7A5
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915833; cv=none; b=i6j6UHolZqEaS3pfl/ZJUe58UToIcDJZnFeDF88CoAczSKREUiyAvQ58EzbbVfJW2z3Ir63mU1FTMoKJ4390ldPCfXzDMDK9QXp2cR/AINjo/jYNyzZ72Apz04XVBvK9v+K3XUHjaYEK90SN9Upnx9dMtivoCOcHBR8H6IWYszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915833; c=relaxed/simple;
	bh=lAkQdC07D/UcxKmv0q2TRAXkWZ9SauyM1tp+dx+ruto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAcPxobvYlPIKsioNFzPtHnrCKoWrk/1i0ICUgAEhRAcODZLneWspbOwNCq7VqWDVClK6mm+MnsKYPob6M514e1ISpDskDo2TEN4ZOJ14Bc4QTe3ynOgslR9UkfofIgqLLdDKmuk/oS0X/6MF8NfPY/cg8ileyovKakkcwQozDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggPcUWnc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so164221066b.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728915830; x=1729520630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpMGgBKekJgMd3kY7Qo0MhCO7mjylLKuxvJluUBtXRs=;
        b=ggPcUWncjXgK3uFWFsHvKYWcQ1MLRaKkl8FzM+upQ0RMm+38HMjC7hYfpY99/ZXXAt
         cxStkirmI5pIWX9SL0v8EDuP1mbDjlca02C6zeSvQ0cSmJCSEiHtJh7sO0UxoAfxkNXt
         yuIUf/i3fplI85RtjWevxVmHajJhvcZo6xq94E5V0ADuxUqkvsGYLFZ8ZQp6OPNeHLZS
         8vIuoB7l2m7OBeN6/swACJZUWdgsiDDcLz/Xj9Tw+pmUTwG5ZNj2kly/MNev/YCKhRAS
         36kXUi1NJBWNmugS7WEnrZesLeuqsugMoJu6SF5iYYdEpxA8Wqr911D7kGgqPs2yAm0s
         CSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915830; x=1729520630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpMGgBKekJgMd3kY7Qo0MhCO7mjylLKuxvJluUBtXRs=;
        b=A9XPjldMCslcgrahOCBSJBcc9VLmyP7e0xMJW64qI0yUrPPa7EW1+CP5Kui/1SAaN6
         mFv56B93U0Rkn3ZX6YRiLu0N9lNck5qut80eeyKp3q53P2lQNYHB6jmDmSx4BiETwGRP
         fvCNI85jpAAXlk2efS3qcTiWI1J9MGhXdOiXO4A6jjWz6r0HkIs3SGosRP4878sHabZi
         tIXSb03dZC2zke8sRihm+NXWb0eG9EZYgEjvADp3zlDf0ZrC9Zg7X/qiQAvB2vA83M5A
         QLAg+gGOI8S7cMNpu0mPyua/OW23h0aQGiWwjGR74tDs8IPGfckiKC2TuGRSdYPxrrUF
         isNA==
X-Forwarded-Encrypted: i=1; AJvYcCV0L9lhKwbFcj9ANrTvIz0g4+adj7KzZ1pGR1wZ13SaSlfWzdSPStxpRnRsKQiD8rrxoclDib0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFz2iSVwS5p43CUt1HKOx1j8scQE8f6X9A6uASkBadTHnGsL7h
	lIOs05Ii7aTK8R2tcQupjgDp3EyT2Jkhgoi05EUTxYo7mmCrJ45ZsBfICdRByZpN49Cg8LeVSu8
	bR1zZ9paFP9xDp6JFDvQoRADVReTeLpNAbpHz+Wy46fOFKy4Dnw==
X-Google-Smtp-Source: AGHT+IErdgDG8oVAw42nQxKXgfs2cWmpBdYPZ7qIiX+8x3XiYSrGGI1KA4TbfX5xS0UvV3V9REl0ekJznVwDfOVCHBA=
X-Received: by 2002:a17:907:9342:b0:a99:4ebc:82d4 with SMTP id
 a640c23a62f3a-a99e3ea59c7mr777184766b.55.1728915829630; Mon, 14 Oct 2024
 07:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-4-edumazet@google.com>
 <CAMzD94SwQhKO_-8Xi5axbjb7X+Hb6n99yvQFQkzHUMcyKhRFqg@mail.gmail.com>
In-Reply-To: <CAMzD94SwQhKO_-8Xi5axbjb7X+Hb6n99yvQFQkzHUMcyKhRFqg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 16:23:36 +0200
Message-ID: <CANn89iLm+VJFdKwsLNoJFuGzA8KGS7b813e38fhiFLk6R9tFUw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/5] net: add skb_set_owner_edemux() helper
To: Brian Vazquez <brianvv@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:20=E2=80=AFPM Brian Vazquez <brianvv@google.com> =
wrote:
>
> On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > This can be used to attach a socket to an skb,
> > taking a reference on sk->sk_refcnt.
> >
> > This helper might be a NOP if sk->sk_refcnt is zero.
> >
> > Use it from tcp_make_synack().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/sock.h    | 9 +++++++++
> >  net/core/sock.c       | 9 +++------
> >  net/ipv4/tcp_output.c | 2 +-
> >  3 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 703ec6aef927337f7ca6798ff3c3970529af53f9..e5bb64ad92c769f3edb8c2d=
c72cafb336837cabb 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1758,6 +1758,15 @@ void sock_efree(struct sk_buff *skb);
> >  #ifdef CONFIG_INET
> >  void sock_edemux(struct sk_buff *skb);
> >  void sock_pfree(struct sk_buff *skb);
> > +
> > +static inline void skb_set_owner_edemux(struct sk_buff *skb, struct so=
ck *sk)
> > +{
> > +       skb_orphan(skb);
>
> Is this skb_orphan(skb) needed? IIUC skb_set_owner_w is doing
> skb_orphan too? and then calling this helper, but we do need the
> skb_orphan is needed when called from the synack.
>
> Can skb_set_owner_w try to orphan an skb twice?
>

skb_orphan(skb) does nothing if there is nothing to do.

It is common practice to include it every time we are about to change
skb->destructor.

Otherwise we would have to add a WARN() or something to prevent future leak=
s.

Better safe than sorry :)

