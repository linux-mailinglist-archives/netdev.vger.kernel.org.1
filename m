Return-Path: <netdev+bounces-89461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D468AA57D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B41F21902
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD012206B;
	Thu, 18 Apr 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOKgbCGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2F4C90;
	Thu, 18 Apr 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480069; cv=none; b=SE057sINPrK/VU1Pw6izA3TYM/CsT6YuUQiboLOKd/xOTWnKGVmFDEXleJFMpsaTuC9O4VVbzVL6IXQTy/XoUErhpDEKsTtO3Y4N/F0n23NwWy0kFSVHspXBtnTvqEjtNd0pMDNjLJohVNtLitMCT5k6YacMvexJCTYx2M7ciVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480069; c=relaxed/simple;
	bh=65s86Znh/TMncZbIbTs41iRh4/aQFdfmUg1K2q3PPuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM4lZHlCLZdPkQ+QUVMproA3HFFmw4vCNajEu9/MtA48S1bK7/7D3K1y3FxWccdfzN/lFFiDLuBSze6aOCTIkQgYsnuXTbNsCQIwfTt0wrPAzGKNdwOPd5EL5GsQ/BOjjY0QuHIseYssnaDKEUY66rZlW3iYJiG/nQM4TnAIOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOKgbCGc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so1467657a12.1;
        Thu, 18 Apr 2024 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713480066; x=1714084866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=howsgI2I5TgSbulsoJY74muz5rwYbpEbVq7yZZ8cUrQ=;
        b=bOKgbCGcUT1TXawEP8tQTNjxmcZvdeHnXxgfLkdP5NvWiGLPjj4temT1jPTkAQyYzo
         tudIg/tQ8I7XmcyO8NkffJLNM9VlHpJTS+VLjWevuNdEGmnlHOE9K1CsVIonRlXbME9x
         FB7AeNbQQVr1tVNe8sK1FVCqpNgHsSd2c8Wm7lJeUTBVYFWbos+vtLMux/Zlajr2Z4OO
         Gc9EefKdZvxnuPUEY12YuKa5QQhvjpWLoAdGgqBCVkOastNa+Ufl/Xa8FkfjrKTqqXGR
         QyHVmB+XbL7PSKIWQ9sDp5VpH7Lw541DzO1/m98XAJDjkxhA7ULTrebx5XVeQDUWUWGR
         qKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713480066; x=1714084866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=howsgI2I5TgSbulsoJY74muz5rwYbpEbVq7yZZ8cUrQ=;
        b=oXuoh/fpUNAfhcGB8XQGev8P98KgPJNbGseEZW2EAVRA2e4lM8jztALZmO4+671mK1
         oNYE9J+uX2qoUzIfAnUF6wm0OyaLWWsi+HsXehftGAyXhJ7j3RLBdvrrHgPaORJpVR48
         yZPZZBexUvmdd87NiHWq86KN5AgWI4FfBM37fP/XLYyOZktxg+Xh7SvuXZa6v26dMCXT
         BbLRunI139l1egys+KCPi06dHYwphroHbNUc8wDEXFNEmttABZ7Fow5gpNj6QFELgSny
         z0DoUV1Ojf6/fZ41XBhb9Qhvu4b/ttIHiNsM9LoqMSKZ8WwAQtj2kFoSjrtEybsnqyVH
         /iAg==
X-Forwarded-Encrypted: i=1; AJvYcCVGdnix5T6uz3Rzr/sQwwBYdAIuFzKSdbPZwyXCl//EKsWaYhxHlFF+RWgESjHE/qAUg1mTp+jk1LlfgMeo0Bm5KgmgET0lpRlPgzhZVtiYK6eUdzT+R2Xohqs6SWyMO5DivZu0zpZlZX2V
X-Gm-Message-State: AOJu0Yyx4U+JfgG0QW3SUto3+PzL2bvRfYm1zOKXob9c9kLGC088saAu
	hoIYZDOEjWMTvlJWrInCRceAsoMgpuiDu2FHBdkoo0WhrKneROGe/GMh+PUeby49AeeRxDIdKjb
	ViHLaoebXTmeK8bXgYQ4mW7xuw48=
X-Google-Smtp-Source: AGHT+IEorWWwe9wcnoC67rKnLRUtqIhI+AMU8yxRVsVBFpVA+Ddweue41FpISTjMrE1QdfifAT5IrJdi8h4xVrgGOrk=
X-Received: by 2002:a17:906:1f52:b0:a51:95f1:4308 with SMTP id
 d18-20020a1709061f5200b00a5195f14308mr283870ejk.51.1713480065488; Thu, 18 Apr
 2024 15:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com> <CAL+tcoBVYWaMAYRdBC6UKiNuhdR7cK+570=0Kw1MKEhPhBL_AA@mail.gmail.com>
In-Reply-To: <CAL+tcoBVYWaMAYRdBC6UKiNuhdR7cK+570=0Kw1MKEhPhBL_AA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 06:40:28 +0800
Message-ID: <CAL+tcoCyuOsNyuuHZG_BBZ5YPNcXHu4v-3Zv4a7JMpLFWwCX5g@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 6:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Apr 19, 2024 at 2:51=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Apr 18, 2024 at 6:24=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > >
> > > > On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > > > > I'm not sure why the patch series has been changed to 'Changes
> > > > > Requested', until now I don't think I need to change something.
> > > > >
> > > > > Should I repost this series (keeping the v6 tag) and then wait fo=
r
> > > > > more comments?
> > > >
> > > > If Eric doesn't like it - it's not getting merged.
> > >
> > > I'm not a English native speaker. If I understand correctly, it seems
> > > that Eric doesn't object to the patch series. Here is the quotation
> > > [1]:
> > > "If you feel the need to put them in a special group, this is fine by=
 me."
> > >
> > > This rst reason mechanism can cover all the possible reasons for both
> > > TCP and MPTCP. We don't need to reinvent some definitions of reset
> > > reasons which are totally the same as drop reasons. Also, we don't
> > > need to reinvent something to cover MPTCP. If people are willing to
> > > contribute more rst reasons, they can find a good place.
> > >
> > > Reset is one big complicated 'issue' in production. I spent a lot of
> > > time handling all kinds of reset reasons daily. I'm apparently not th=
e
> > > only one. I just want to make admins' lives easier, including me. Thi=
s
> > > special/separate reason group is important because we can extend it i=
n
> > > the future, which will not get confused.
> > >
> > > I hope it can have a chance to get merged :) Thank you.
> > >
> > > [1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogy=
svgR8FrfRvaa-Vg@mail.gmail.com/
> > >
> > > Thanks,
> > > Jason
> >
> > My objection was these casts between enums. Especially if hiding with (=
u32)
>
> So I should explicitly cast it like this:
>     tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> ?
>
> >
> > I see no reason for adding these casts in TCP stack.
>
> Sorry, I don't know why the casts really make you so annoyed. But I
> still think it's not a bad way to handle all the cases for RST.
>
> Supposing not to add a enum sk_rst_reason{}, passing drop reasons only
> works well in TCP for passive rests. For active reset cases (in the
> tcp_send_active_reset()), it's meaningless/confusing to insist on
> reusing the drop reason because I have to add some reset reasons (that
> are only used in RST cases) in the enum skb_drop_reason{}, which is
> really weird, in my view. The same problem exists in how to handle
> MPTCP. So I prefer putting them in a separate group like now. What do
> you think about it, right now?

The description in the previous email may be too long. The key point
is that we're not supporting only for passive resets, right?

Thanks,
Jason

