Return-Path: <netdev+bounces-100228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B9C8D83E0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB78AB233F7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D0212D74B;
	Mon,  3 Jun 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7F6i2vx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEC84D10
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421215; cv=none; b=UXxXD06ahlbH6gcO2IMwQZ8ipzfkwlBzbjr0MGtmJw2O2OmjJjWHNbIaoHAQ+GSXC32jD7R00R2/FjkdhHaO5+rcMPa0ZBlPrZD6QMpIFSwQsNBUMbN4LQnvaNxdXXeYuMVsqwg7Hzi2Ica818V0LK3l2YwalAXuHE1H21+vVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421215; c=relaxed/simple;
	bh=ZM00yZhdUZbQwgMyHZIZJ1UP3o1I/SZy0IsztqNd6L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8FxAlKAwtofG+MV79/ebX7xUTYg6P9DDh9VzMxPT1jC7BvJNY+S/d1c43qgPipKKFXbNGZG923VsowVU39PincdZPZipwKOERcDzdJQk1Qr5w3R2dd6mtDz4tUMnU9dZxS50PpZbbDC+o++05LxKM9nRfNU/CCxJFPm3Cm1ItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7F6i2vx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68f10171bdso160536266b.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717421211; x=1718026011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUsHEgYLwi9mPIr/q9q9dBz6ihvAh5JXN+fvicM3xcM=;
        b=l7F6i2vxqpA3BA6Xsb61+D1hQVTYF+JCch/V5vcBlz8KSv555Q06GOAC8KIpOqnCz+
         Q17XuvA6JHcyFRLf5c+YbWSZEgXiW6l+pyF+nZhH+9BFUhho1xOsNcX1z8w8O5lYwbby
         Y8+T5iUCF2VwmhKeT0Jznj+GsTnR1zhXsee6HdcVQc1Ko0S+h8XxWZ0jVLEJ0p+LWH24
         Td1deWdhintIKMN1DGa2mIB2ly2WRgkHBoZwgJPfd4zd5RqubiVCGX8KJ8392jEjK2mE
         SGxswPCrDfmRXiwzyP5SJgDTm4B0ngBsAbZ5C2RriQDeU/luuTWeVhlg6RpDMi7yLIQN
         ekrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421211; x=1718026011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUsHEgYLwi9mPIr/q9q9dBz6ihvAh5JXN+fvicM3xcM=;
        b=AjIPbzZIs4P5AnkqhXsW/zWiJaocyY4yJR9DZAY1FcrnJMjpgu93Uh2HmijQ3ZFvbA
         VGkRqw26/ccwku0kSIQ8lSk/QBvXx29m0p1O1UwPB11Hdv2aOhkWZOWCKg98PRQkzyU6
         FAE9iRZ0cFa1eKKAtpLj1ZuXKLur8BM/7bAYm+B4uBl49HyeXEDYW1yLKuPbxl0LC/Ed
         5SjZWq3aJ+cp5exbX+LaQ3KeqLbEpPEotCnxngmVrkx5NJUDsknGSwEOollG2ITfUcT9
         TH6u2AIN/DlRe4Iis6wWlZSaF8MEQCG+qVm3VLLiC8GBoI/wYGpPJshjrsOfs+RR0KGD
         rx7A==
X-Forwarded-Encrypted: i=1; AJvYcCUQRMiDO8mHpVM6UclfPAVdb0a698XYXktrtL1qO9PQs7NoFbCkE4boqDnDVYChbGYOSIeFNtJpgwus1fP06BlmO7al/Id8
X-Gm-Message-State: AOJu0YyyyI89VWJZkY/W8p2z2f8r3zSjV6pvf5Z0I2/ip12v/Pudlnr7
	YsQa/Js6BKxsQaUW1xPvkUES1Hwo36LrE5kgbkwNg8otw5A2Yy1mMEeWv174ihUV6SOgQ2xxWJx
	cfFHlXwyv7XtQhQy0WnYBRnblobE=
X-Google-Smtp-Source: AGHT+IHW9AA3rKOnHVlHU09vyfnmpr6TqZfW9sJiedTI2sYHJwKyb9Dva58QsQmxE8IhX2epqvK/kz5ShXge0HfZXJ0=
X-Received: by 2002:a17:906:154e:b0:a5a:51dc:d12 with SMTP id
 a640c23a62f3a-a681fc5d769mr770199666b.2.1717421210368; Mon, 03 Jun 2024
 06:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
 <20240531091753.75930-3-kerneljasonxing@gmail.com> <df99fb97-74ca-4b5c-9d5f-86466025a531@kernel.org>
In-Reply-To: <df99fb97-74ca-4b5c-9d5f-86466025a531@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Jun 2024 21:26:12 +0800
Message-ID: <CAL+tcoAa+8pEcW5C3jjU4cieHBm8PUWMKUR=hP8sqQbh1gmVug@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Matthieu Baerts <matttbe@kernel.org>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,

On Mon, Jun 3, 2024 at 8:47=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Jason,
>
> On 31/05/2024 11:17, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like previous patch does in TCP, we need to adhere to RFC 1213:
> >
> >   "tcpCurrEstab OBJECT-TYPE
> >    ...
> >    The number of TCP connections for which the current state
> >    is either ESTABLISHED or CLOSE- WAIT."
> >
> > So let's consider CLOSE-WAIT sockets.
> >
> > The logic of counting
> > When we increment the counter?
> > a) Only if we change the state to ESTABLISHED.
> >
> > When we decrement the counter?
> > a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> > say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> > b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> > from CLOSE-WAIT to LAST-ACK.
>
> Thank you for this modification, and for having updated the Fixes tag.
>
> > Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/mptcp/protocol.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 7d44196ec5b6..6d59c1c4baba 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int state)
> >               if (oldstate !=3D TCP_ESTABLISHED)
> >                       MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB=
);
> >               break;
> > -
> > +     case TCP_CLOSE_WAIT:
> > +             break;
>
> The modification is correct: currently, and compared to TCP, the MPTCP
> "accepted" socket will not go through the TCP_SYN_RECV state because it
> will be created later on.
>
> Still, I wonder if it would not be clearer to explicitly mention this
> here, and (or) in the commit message, to be able to understand why the
> logic is different here, compared to TCP. I don't think the SYN_RECV
> state will be used in the future with MPTCP sockets, but just in case,
> it might help to mention TCP_SYN_RECV state here. Could add a small
> comment here above please?

Sure, but what comments do you suggest?
For example, the comment above the case statement is:
"Unlike TCP, MPTCP would not have TCP_SYN_RECV state, so we can skip
it directly"
?

Thanks,
Jason

>
> >       default:
> > -             if (oldstate =3D=3D TCP_ESTABLISHED)
> > +             if (oldstate =3D=3D TCP_ESTABLISHED || oldstate =3D=3D TC=
P_CLOSE_WAIT)
> >                       MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB=
);
> >       }
> >
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

