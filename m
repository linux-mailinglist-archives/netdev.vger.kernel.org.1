Return-Path: <netdev+bounces-167081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E6A38BE1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F89518937C6
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D561235C03;
	Mon, 17 Feb 2025 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRvEnjpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B5228CB7;
	Mon, 17 Feb 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819113; cv=none; b=gUeLBaar8Sr5RhXsaJt5NRAoVN/iG0yUp5jJ3rcQKz50zF3dCnLbLAXoNLvYwhshSAy0fNhcwXQnWe0yiHqRx346Y3ji7RA72SEDGgL+8nQ3zv0hQ/TYs7QR4rpOzhbjO4SeYaeRj3izvwb3h/13j7kqGe8jmBEcZ6ZEIpWo1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819113; c=relaxed/simple;
	bh=RPskkqbaNW21ehKIYfEfNFLQLoxMN20fJReVtLMfZiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9L3eX8cifMuaMNplesNyWMXHzxATgitVD6q0O4P3JBzBSuE8EV5moJeCpVUeRejx5xJReg1+194bZWdm+n9jSHibwV8HZJu/xu1wLI0maKN/70/M9sH+655/SfB+QQytqpDesNXalqSVH9a0pvHma4+T32SsT/BI/H8Ptp8k9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRvEnjpy; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f3fc8f5ffdso288140b6e.0;
        Mon, 17 Feb 2025 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819110; x=1740423910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9LcNXhBDFpkuTJe4Uy1LJYi6piFdxgiASQiQasAa30=;
        b=WRvEnjpy9KKo95PLwKuLfHA2F9fY1pw1SuymTc9KsiWCRLbVJnNrltBqBE0B0ve4jZ
         KlRqP4sAVbEZUIP/3ckUHJ8fUe24pJ1KKFZ3lCSn4WUcx6MZHm4WYiCqpYbM7pzhRUPo
         BwPe6uXLv2ybmWj/WqCWuGrR81i+dBmwWpdAJBE6L0XRG/3khAXZhFhsJ6F1n8Llzf09
         SSAiOG79ZfL1ADqzXRC6R+NIqpdT247Ez/aicUqbnFkMWpvuVFsMCuK2+N2mAXRm1NCs
         Qe8Z17+CjUEtG8ToeBG9RG2+LnU0erPqK377sbFMWLDR7wD4sf5z0t3dqkVwS2v8wIK9
         SDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819110; x=1740423910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9LcNXhBDFpkuTJe4Uy1LJYi6piFdxgiASQiQasAa30=;
        b=nS5kGa7kJJIm0UmmvYBWTQVGyr+ovEOrP7Vhu6XYgWEntX68H1j2GnpIrD/lNixhXE
         4OFWolS4sCsUtzKKPj/nfdEseysS+ZHR5oELyinOudRgFbfhJ9uheSEehRmvFPsGMj+j
         We9SDkfW8r9oZJyFl+qCGnxOPk14MGSSSijor9hv35JXH2go++pgxVhgR+XB4xQYh4zE
         nAWLD6TBcQELzOiS06jCLvFGOhKRay2bqnSk2OQHn3oEt7wArqX35ZF79EJEViM/FBNI
         kw99YBF/4r8VjqCRWWli18GfaKoSwFze35NBJ1xPlkfZ9UmfqpF1vwqfFa8U3MLuKnBG
         lTPA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eqwxu0cGfIsMQXJTEmZYsnZ/tbu4UGONVK40kmTbucgdjmmnYFR4UVneA8oFN8E7XttdwXDKGV8FOvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mu1uKiCReEX/6xRLfVBHtiWsOtQLSEmjLFQGIe7+p58NVehM
	5r0hBIhxxUy6WRvJz1uf6rt5rjQ8xp3WEylPI6DCNNHWN5RgaAdPDyNl2Kx30bi2A+/P2b/xwP5
	mQB4sJQmP1DmlN0y5Jt6Zk1yryD0=
X-Gm-Gg: ASbGnctdZ4OUFGuXda+N0nOF9OqxfhDJYoTwhANgwqN/m3TSJwfwfUXPrUrKq1HCMaQ
	5W+R5r1RYiEouFgjdQhVbnCHg6Mn1Qa37rt2w4b/9opljBo9qKs57kLBhdjbcr0co8QCZQQQ=
X-Google-Smtp-Source: AGHT+IEGUO+ZKW5MdSbkeK7bIPHZpL9q92U612lbCxDsvfg2NvHooHiWe6mGJE1DbxzwMq8gJ6pgOBgWgRR9vwNigzg=
X-Received: by 2002:a05:6808:f89:b0:3f3:e81a:d244 with SMTP id
 5614622812f47-3f3eb11b254mr7490498b6e.31.1739819110557; Mon, 17 Feb 2025
 11:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
 <CANn89iLjxy3+mTvZpS2ZU4Y_NnPHoQizz=PRXbmj7vO7_OGffQ@mail.gmail.com>
In-Reply-To: <CANn89iLjxy3+mTvZpS2ZU4Y_NnPHoQizz=PRXbmj7vO7_OGffQ@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 18 Feb 2025 00:34:59 +0530
X-Gm-Features: AWEUYZlOdUlqrxjWVWF2pcnSub5BpZ5scnbsGSXPPLTq5j20PzqKxfTetl2e7Ls
Message-ID: <CAO9wTFjaLBbrT7JKBBN=2NMhSRmxzPk_jLSuG=i6Y5anZJnvEA@mail.gmail.com>
Subject: Re: [PATCH] net: dev_addr_list: add address length validation in
 __hw_addr_insert function
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
Thanks for the feedback! I'm new to kernel development and still
finding my way around.
I wasn't working from a syzbot report on this one; I was just
exploring the code and felt there is no parameter validation. I went
ahead and made this change based on that impression. I realized my
changelog should have been more generic. Sorry about that. Also since
it's not based on a syzbot report, is it good to have this change?
Your insights and suggestions would be most welcome. I will make the
required changes accordingly.
Thanks.

On Mon, 17 Feb 2025 at 23:58, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Feb 17, 2025 at 5:54=E2=80=AFPM Suchit K <suchitkarunakaran@gmail=
.com> wrote:
> >
> > Add validation checks for hardware address length in
> > __hw_addr_insert() to prevent problems with invalid lengths.
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >  net/core/dev_addr_lists.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> > index 90716bd73..b6b906b2a 100644
> > --- a/net/core/dev_addr_lists.c
> > +++ b/net/core/dev_addr_lists.c
> > @@ -21,6 +21,9 @@
> >  static int __hw_addr_insert(struct netdev_hw_addr_list *list,
> >       struct netdev_hw_addr *new, int addr_len)
> >  {
> > + if (!list || !new || addr_len <=3D 0 || addr_len > MAX_ADDR_LEN)
> > + return -EINVAL;
> > +
>
> We do not put code before variable declarations.
>
> Also, why @list would be NULL, or @new being NULL ?
> This does not match the changelog.
>
> >   struct rb_node **ins_point =3D &list->tree.rb_node, *parent =3D NULL;
> >   struct netdev_hw_addr *ha;
> >
>
> Any syzbot report to share with us ?
>
> Also, a Fixes: tag would be needed.

