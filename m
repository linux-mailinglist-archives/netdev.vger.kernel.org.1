Return-Path: <netdev+bounces-97315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2F8CAB90
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD314B20910
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E46BFA3;
	Tue, 21 May 2024 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ualeSL0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416756B7B
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286378; cv=none; b=GLE1k9G2+UIh0pgPHew4Bg9l0vEvu4YqLkAjr04Y2FgAJgm/UkB8/cIRfehB09wzpZqLBfbQyAj9r7MGHZFB9l9mIDbejwjeXosV73BcSDemMZXPDnqxevS0jQPj+Kawc4K1VkCxl8WyWV0GeLgW9yk9JxCWgJH2GWlJcfmWu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286378; c=relaxed/simple;
	bh=81iT+BRUUjSYJEu3/Hs3xxwawY0+QNRshNXe8/WnHhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFCS6Kz5TXCxNRAj2AnnhOV7s5WbXoY+P1hGe4pxgHu1+z5jYiap97yi1hs7hZkDrG4Bu5JxnFXiTkIVKLb/8ys7DEesMU0dr+LElbN4MTUshpbk/3yUqQdRFxsZXcPLnyYifKmFVL+lRWXt3vREyP+IG+faChaSDQCbr/fWrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ualeSL0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso28280a12.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716286375; x=1716891175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kT03MirJEvh1ObmDBHbmFe/vTGdLYHTa2/ZsDS+/7c=;
        b=0ualeSL0OTDKGUitegsOWhJSKXgWj/vEzVjDLywu7SRwjmmoBP/mcwnyisZrBdB+uA
         VOZOG6HktCNsnVvhd/pvWMVYufzvdVaQi3fBdzoabC/qj1U+dPfkrH2P41qRxWnfhqNr
         9O8jHnuWfAm7fwOavZV7zDtxgyKCOn1I0MggJQb0cwsKnUXj0G4ZTfQXzREtnxI5+OrH
         hfHZFR6O3Z3OPn/h07NsKGLljsv07oG0R9ORyExfSAwWvm5YU8cSgJgwsMEV9rwIc8Ui
         BXc35Rvsv16DXyzG5ei/1t11AIajeOnAhsEP+84xIOhDeTV+zfxkD1hHJVY0RbentShe
         XSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286375; x=1716891175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kT03MirJEvh1ObmDBHbmFe/vTGdLYHTa2/ZsDS+/7c=;
        b=L5vwwGv6J9TWBl+R5DmeUKQztb8fjel0HAkNT34ft5YmG9n+MsyOm+Rmakeq12xjeK
         +Fi/0zXKmtC6Z+qAgJYoU6DZ+5NRZqsWS78y9tNJ5z9mtXJFIUqDiJLnijq+NWH2St/E
         PjklNBWZlGf8oGsMXl+FYnOlNe10qbzBVrLGQuBf5e3XqmguAL+eYhZlxsc1Gt6wDI6c
         zXmUwFFpnbn6RuK3wSWel3kGcDURP4+nGjGwDZ42cIoTF/LynZ681e7ymmUbkril8BIH
         a9k6kf2p1qWi5EhWJlZ4Ifsxh+zFtAtdRayISXlA/6scCtdgIPoGLuPo4UTcbPxGcDIQ
         DMtg==
X-Forwarded-Encrypted: i=1; AJvYcCUyBmgJiUG1Kv2GzSMdwehPTHC8UW9hD8lWRocN+f/KuszttO4bmDLOrpAEaRDnF9Hr5xcyTbzQpnlxP6H8CRrdMXyUGkVT
X-Gm-Message-State: AOJu0YyJPia2Ao5AjCQKLzNdwBDN9OhOBl7wOIgkbp9hygWDv6JXPf3+
	h1Jij+RKYU7/JVYl7Lkz009IRN0itzEFutfXUhomKoMsu01PmIzK+KcI2R986S3vYCFa9KkK7/B
	HEnU/pNe6uUC+lvMI8MCfKzanvGa/GlZ3OVOVMkRe+gECsH7+ng==
X-Google-Smtp-Source: AGHT+IEvwBuxs7E1wXHaSzZxDTNxHo3qNU+rWKNZRAxDs810d6PdEN3s/+5hXyUMyzh20Wm7D/dctYMKLLO+0879h+0=
X-Received: by 2002:a50:e60e:0:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-5752c8c2675mr473194a12.7.1716286374837; Tue, 21 May 2024
 03:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYAPR01MB64091EA3717FC588B4ACF045C4ED2@TYAPR01MB6409.jpnprd01.prod.outlook.com>
 <1f42042dbfe9b413cded5e5d59cd3933ec08ed08.camel@redhat.com>
In-Reply-To: <1f42042dbfe9b413cded5e5d59cd3933ec08ed08.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 May 2024 12:12:40 +0200
Message-ID: <CANn89iLgAEPQF934aNFk5o0mhHUdYra8UYRFxep1oyqk3SsEtQ@mail.gmail.com>
Subject: Re: Potential violation of RFC793 3.9, missing challenge ACK
To: Paolo Abeni <pabeni@redhat.com>
Cc: hotaka.miyazaki@cybertrust.co.jp, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 11:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2024-05-16 at 16:12 +0900, hotaka.miyazaki@cybertrust.co.jp
> wrote:
> > Hello.
> >
> > I have a question about the following part of the tcp_ack function in n=
et/ipv4/tcp_input.c.
> > ```
> >       /* If the ack includes data we haven't sent yet, discard
> >       * this segment (RFC793 Section 3.9).
> >       */
> >       if (after(ack, tp->snd_nxt))
> >         return -SKB_DROP_REASON_TCP_ACK_UNSENT_DATA;
> > ```
> > I think that this part violates RFC793 3.9 (and the equivalent part in =
RFC9293 (3.10.7.4)).
> >
> > According to the RFC, =E2=80=9CIf the ACK acks something not yet sent (=
SEG.ACK > SND.NXT) then send an ACK, drop the segment, and return=E2=80=9C =
[1].
> > However, the code appears not to ack before discarding a segment.
>
> Note that in some cases the ack is generated by the caller, see:
>
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L6703
>
> In any case not sending the challenge ack does not look a violation to
> me, as the RFC suggest (it uses 'should') and does not impose (with a
> 'must') such acks . Sending them back too freely opens-up to possible
> security issue.

Yes, this behavior was added in 2009, we lived 15 years with it.

I do not see a pressing reason to send challenge acks here.

Hotaka, please explain why this would help a valid use case (I am not
speaking of broken middleboxes)

>
> side note, @Eric: it looks like we can send 2 challenge ack for half-
> closed socket hitting RFC 5961 5.2 mitigations?!?

Sorry, can you elaborate ?

>
> Cheers,
>
> Paolo
>

