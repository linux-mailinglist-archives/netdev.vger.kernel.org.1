Return-Path: <netdev+bounces-89460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F108AA573
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 00:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A5F2848B4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD39199EA8;
	Thu, 18 Apr 2024 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkYIUns+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578718410C;
	Thu, 18 Apr 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479400; cv=none; b=jtgVrbOcQNTexDkEkhj26CuYHeHcrcxjzXxHyVGbggYks0q+iSDS8U1WhymAUGXqHnzVfZPkaKyiBv2IwYsLwuTdBYfj1OatqFtG8y/UIxBJHz+a2/462/1l9vmpcnpur9p9wxVnGCPJfbb27va3XRbbEIIutgXk+MSXmlqQAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479400; c=relaxed/simple;
	bh=jny9PTEeGCQgR6BpCNvvucw65gCkhQ8IJ4lvib0jUHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxg6hA+Z8jYse3j2WhhbIjU44eLD7JzHhAm/YrLurOK1wSdQ59T8KXfDw/SxiY/ZIfbXll1GIkPnCtoHAqOCm9PBFteIPmoaDFp9uhRfkkkXX/tKyIiJoRUfDpAQdnQepCRGzPkbcLFdUXMziKBWb++g044YhJzZ8drc/RVajz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkYIUns+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5252e5aa01so171795366b.1;
        Thu, 18 Apr 2024 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713479397; x=1714084197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+4KvND2mQ965yY+mYlrwgLNNZfgfM81bsxNc9865q0=;
        b=kkYIUns+Vg///cRYbI/zIfbQs69OcbOKvnxU4bgcl8ZNVPIgMt8UKObIRqx0lVoQNp
         4pnJ4s/N7ROBO7zv2ml8nw/WQ2kgnikCfPz5L5gdgeRr7miL9o+BC15F7mnpTLyrLsQ8
         QjoC7bs2KP66o1l12H2gzoyl26Y//6fyf3T8wWKee3InnL4NHXYwoYOPGF67FJ+vuT6I
         f53d6yBJgCqsQ9EjXJez4DasaMCyIsnpsCSFCX3pXdjsfJphrB6eaFR/lLjx4LRSU1f8
         ABjiEj6jOLFsp/le1fjAksvkFxMQB70A+fWW7q3knd9wzlQ+XWm1UeyCPpeu7jAwGs1y
         pJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713479397; x=1714084197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+4KvND2mQ965yY+mYlrwgLNNZfgfM81bsxNc9865q0=;
        b=tF/89k/cmYCQQykhJ6ATlecL7Uv58+D3eil3j9oLwDA2Hyzvzg/cAXluzcxsi03Fxt
         DqE4DM9SWy+O+T/FbJvqhBEXF5U6AxhBIKi0Dc8cmpLWhphOvn6P3tyH8G8zLK926sVc
         9b4ALQ+AWGtYo7imyBA/TR1mRwPAlY64XbxagFHBQLSjfuTCceZwkHNi8qXohI/LSEUF
         EAMPyG6ueXHLkh9tkcdT7qnor01SYffqzvPInUr3+gmkPAFBO//Z7LKfqUIVUKjV7V0D
         LxEq/4IoRolFda81K6YfAPOMUS45ErfNWn3F7G5kzplz/H0uymObkhWkFaxPk9uMrBs/
         61rg==
X-Forwarded-Encrypted: i=1; AJvYcCXfiexOEBMBgJ1DQakhSFGIbB1onb3zxJdF2tnhAB0mMbvv0nM5+JPEoIbkvvnUHkCUembQkud/Wt99cePrqZM2/mPkHCFxq0q3cs7W2e32dWShZT4dyiARTdewcwfReBCQs8VwvVG/KKEd
X-Gm-Message-State: AOJu0YwN4CVfkBzfhp5KYZ9iWx3h0PW4ZINl7WxcgAxN3xNNdwYVNERu
	h/lHkMp2J8FF+I79G0sQy1b0SIM2aFqBlGyRYJug+gXZJ4by5gPCnwS7lkDgQ86v8OmRVEk2hOG
	RBl3Uqm1PRHuBdHSVSYzTQtiWvxA=
X-Google-Smtp-Source: AGHT+IE6V5mFUZPVGUU2SzTgBj9jbHCjqFZL9dLnzLdH+rsYdJvHGFBAYrSPLP1rELbC3l9mAh5Ete7xbMLWCE/4MbA=
X-Received: by 2002:a17:906:855:b0:a52:5a6c:a359 with SMTP id
 f21-20020a170906085500b00a525a6ca359mr221188ejd.63.1713479397058; Thu, 18 Apr
 2024 15:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
In-Reply-To: <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 06:29:20 +0800
Message-ID: <CAL+tcoBVYWaMAYRdBC6UKiNuhdR7cK+570=0Kw1MKEhPhBL_AA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 2:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 18, 2024 at 6:24=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > > > I'm not sure why the patch series has been changed to 'Changes
> > > > Requested', until now I don't think I need to change something.
> > > >
> > > > Should I repost this series (keeping the v6 tag) and then wait for
> > > > more comments?
> > >
> > > If Eric doesn't like it - it's not getting merged.
> >
> > I'm not a English native speaker. If I understand correctly, it seems
> > that Eric doesn't object to the patch series. Here is the quotation
> > [1]:
> > "If you feel the need to put them in a special group, this is fine by m=
e."
> >
> > This rst reason mechanism can cover all the possible reasons for both
> > TCP and MPTCP. We don't need to reinvent some definitions of reset
> > reasons which are totally the same as drop reasons. Also, we don't
> > need to reinvent something to cover MPTCP. If people are willing to
> > contribute more rst reasons, they can find a good place.
> >
> > Reset is one big complicated 'issue' in production. I spent a lot of
> > time handling all kinds of reset reasons daily. I'm apparently not the
> > only one. I just want to make admins' lives easier, including me. This
> > special/separate reason group is important because we can extend it in
> > the future, which will not get confused.
> >
> > I hope it can have a chance to get merged :) Thank you.
> >
> > [1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysv=
gR8FrfRvaa-Vg@mail.gmail.com/
> >
> > Thanks,
> > Jason
>
> My objection was these casts between enums. Especially if hiding with (u3=
2)

So I should explicitly cast it like this:
    tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
?

>
> I see no reason for adding these casts in TCP stack.

Sorry, I don't know why the casts really make you so annoyed. But I
still think it's not a bad way to handle all the cases for RST.

Supposing not to add a enum sk_rst_reason{}, passing drop reasons only
works well in TCP for passive rests. For active reset cases (in the
tcp_send_active_reset()), it's meaningless/confusing to insist on
reusing the drop reason because I have to add some reset reasons (that
are only used in RST cases) in the enum skb_drop_reason{}, which is
really weird, in my view. The same problem exists in how to handle
MPTCP. So I prefer putting them in a separate group like now. What do
you think about it, right now?

Thanks,
Jason

