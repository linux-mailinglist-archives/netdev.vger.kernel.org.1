Return-Path: <netdev+bounces-71510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD08853AF6
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C3D1C21E2B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2D5FF00;
	Tue, 13 Feb 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jyW1WAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45C605BF
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852711; cv=none; b=HYOpopjbrG92+RCflydv/uXyTGsg2IfkwjDDYFHjcx8GUZt/zTGLzOaVgCzwEWfDMwA9NOFGcXbDYB5mEf7FCoqq0FAxQ9gxZhp4v6tQJbirsFDX0FQ3shX8wAPdGmICqcdzyVMkmGO1Ffag6/pm9nVv+4vRawIdv6m4MhbOec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852711; c=relaxed/simple;
	bh=L853suOz1gnZMXIQGqY/C+hU2s27OIYyZVPzqlb9XLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNtu0YInEuh7fU+8eTvvmgZaqYT5lsQY5wUFgiesP0ESNcQ4/Wcbzq+wqb1gi3ozhvjrL8FRAjMsu1NrSPl5zyeITPbO/FXaI8F0AtmlsUzwgQuxqknwu+os0HyQgS9YDFIL6aPUjkM7vAYIDq+IlDeX8hECzPcuBkbu33ToKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jyW1WAL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso15431a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707852708; x=1708457508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVe2S+43wcZf1yVZqzunJxN7pTPJqoR3PVQTtg6Fxq8=;
        b=3jyW1WALo0V1fM5egk/KkzpCKMPjnGyz/GctMdj8FFrg809bWkkAEMpQvBzacUDmsr
         ZSAKDmukT+NBMgJUIzh07uQrxoDZznS3jldoQmwYhJ6ejuTG4ti44uCYUHoGZunxmgY1
         u3dFD/JUAXHciNGweUgFAaMSNm7JPR8PAypVrG3Hw3RRAO8OC4LA/yN4Gzxmadym7Q4F
         pSmBXUvFvWX44YY1T8/Y7mKEbe4Zjbt62R/+WfGX86tgl7Wiyo8zqiKpMXnVy0Yp1nZR
         KvLpBKN3rhDlvd33fdChY6tMFS+pl1Qe1qKgWlNuuUNuUySvXujE5+0/vys4oUC/+YDd
         fhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852708; x=1708457508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVe2S+43wcZf1yVZqzunJxN7pTPJqoR3PVQTtg6Fxq8=;
        b=YtU6boWTIoqrdPb2n5V17Kk3uZgWWdWfIRUn+V9W9zPBMz/a6tNd86EsFy+5W6s7UZ
         Ndzk7GLI4qlGGybgF+qjfweKAy7zXxkszpTa48P7ucoguOXIaW9ke/c3fT81lJ79juR4
         fVETu25EhPU4ulGN+UPEKnbOTys5RWWH8ASOkle9YdoiyRfKnvc2JFBC/KHZxDrY4ImV
         vevOcaPoBHnbon3pPn1cJcY5z1yxTgzA5Gb/SVqZV4a/Fw3ChgRp8aqXeqnavFaYKGtq
         62tB38fgDemVk/SKkhpMk36rJP97EUypPmXZyZg6is3hC1toWq5ac6764hxr7TVhQRH6
         59MA==
X-Forwarded-Encrypted: i=1; AJvYcCVQIwxnwh1YwjCOSBTKcmfk+6rLT19V6eu5rFLVaA3HPekq8XRqXpd5cdznHWIupn2PaVd88HQgPI54GGv4Y5OPjKCrbNLy
X-Gm-Message-State: AOJu0YzI2BnH56KoE7ZrOsy7g3npVIb6dngLefu7e0IWMU1yILAZBzPY
	ApdXigivNvkMwHNYQHy5V6vdPwtjmRtqnTThvzfq7s3YKrcsZ10LFcCmq6Z7TDkazSYV0TCNaT2
	UfjqEM5r4nN3hOIU62CBQAKlHQw1hLtgCkjDm
X-Google-Smtp-Source: AGHT+IF2MZMV7QDxWC/1F2duVCX9Tpa+oXcNv2c0wb4z4FzyRI5UZGOxoKnIPzP/dEceS//xa7Lkx8NJ+VbbEo625iY=
X-Received: by 2002:a50:d781:0:b0:560:ea86:4d28 with SMTP id
 w1-20020a50d781000000b00560ea864d28mr54946edi.4.1707852707675; Tue, 13 Feb
 2024 11:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com> <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
In-Reply-To: <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 20:31:34 +0100
Message-ID: <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, jmaloy@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:39=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2024-02-13 at 16:49 +0100, Eric Dumazet wrote:
> > On Tue, Feb 13, 2024 at 4:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > On Tue, 2024-02-13 at 14:34 +0100, Eric Dumazet wrote:
> > > > This sk_peek_offset protocol, needing  sk_peek_offset_bwd() in the =
non
> > > > MSG_PEEK case is very strange IMO.
> > > >
> > > > Ideally, we should read/write over sk_peek_offset only when MSG_PEE=
K
> > > > is used by the caller.
> > > >
> > > > That would only touch non fast paths.
> > > >
> > > > Since the API is mono-threaded anyway, the caller should not rely o=
n
> > > > the fact that normal recvmsg() call
> > > > would 'consume' sk_peek_offset.
> > >
> > > Storing in sk_peek_seq the tcp next sequence number to be peeked shou=
ld
> > > avoid changes in the non MSG_PEEK cases.
> > >
> > > AFAICS that would need a new get_peek_off() sock_op and a bit somewhe=
re
> > > (in sk_flags?) to discriminate when sk_peek_seq is actually set. Woul=
d
> > > that be acceptable?
> >
> > We could have a parallel SO_PEEK_OFFSET option, reusing the same socket=
 field.
> >
> > The new semantic would be : Supported by TCP (so far), and tcp
> > recvmsg() only reads/writes this field when MSG_PEEK is used.
> > Applications would have to clear the values themselves.
>
> I feel like there is some misunderstanding, or at least I can't follow.
> Let me be more verbose, to try to clarify my reasoning.
>
> Two consecutive recvmsg(MSG_PEEK) calls for TCP after SO_PEEK_OFF will
> return adjacent data. AFAICS this is the same semantic currently
> implemented by UDP and unix sockets.
>
> Currently 'sk_peek_off' maintains the next offset to be peeked into the
> current receive queue. To implement the above behaviour, tcp_recvmsg()
> has to update 'sk_peek_off' after MSG_PEEK, to move the offset to the
> next data, and after a plain read, to account for the data removed from
> the receive queue.
>
> I proposed to let introduce a tcp-specific set_peek_off doing something
> alike:
>
>         WRTIE_ONCE(sk->sk_peek_off, tcp_sk(sk)->copied_seq + val);
>
> so that the recvmsg will need to update sk_peek_off only for MSG_PEEK,
> while retaining the semantic described above.
>
> To keep the userspace interface unchanged that will need a paired
> tcp_get_peek_off(), so that getsockopt(SO_PEEK_OFF) could return to the
> user a plain offset. An additional bit flag will be needed to store the
> information "the user-space enabled peek with offset".
>
> I don't understand how a setsockopt(PEEK_OFFSET) variant would help
> avoiding touching sk->sk_peek_offset?
>

I was trying to avoid using an extra storage, I was not trying to
implement the alternative myself :0)

If the recvmsg( MSG_PEEK) is supposed to auto-advance the peek_offset,
we probably need more than a mere 32bit field.


> Thanks!
>
> Paolo
>

