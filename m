Return-Path: <netdev+bounces-97225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9968CA182
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3F41C213D6
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDF3137C4C;
	Mon, 20 May 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsWP4o2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F71137C42
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227000; cv=none; b=aNmYyWMiq/gSBIAkp9jwtlcWgRgfWqyobmV6qyFeqjc5Bl2sXwHbP1DYdlm2WYm3RBLbUl+HPjj5KoF+2/K5VSC3N3eomQDk+daMSVfl4uu9rtyKhSQT4o1LcfPDAZ568e0H73MfIkR9Pmi7rO+YdjKGCqSieJP2NpiZOyTcn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227000; c=relaxed/simple;
	bh=LIPaOy3hPReyuG7YdbCDBVWZLpeEZ9oT6WZ6itAGKhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JN5zv6Uc4iTA0uFU+GW8gNg7OimS1W8TBvd1tTkrBpXM0ZKZnPOG4pis4Z7myneVq+LDzVlwJBvez0+056/1pm3jP2qry4LQRNsqxIfBA2w02plVFB5qRuDT/xKC6mtkBD2plegV0m6hD6NEvglkaKa3A/Omq24t12zxXqxYMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsWP4o2F; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso15276a12.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716226997; x=1716831797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3D1UwEMomuBsnFm+ht0rmowgEPqEk9TJ+sRSS3dZXc=;
        b=lsWP4o2FJnTqWQ0hm5IX1gKI3Kb4tiqpucbwV5kuk9RSszxtFzL9uQ4srCf8dmcpGm
         /lWrRWlzbLBg83nKBzBGBpfpIUw/a81keo+BsYoadU8//VGKLT5TpRdsUZH710UnMR+D
         t6BA3Y2aA0n5V814g+3XMuOwDJYOPH+ABvGDi0NybJgeE5kxz/TOx4LzJWEfk0WdK06N
         NS2os/ph2NGyU2a1zPQfomMyQjFTDxZaXVA7ASp4817jg/08bLBwTM/NDRSACCPkfpYQ
         Zz6u1S6nHpXI0cLzhqs+0YkiOoeNFCHX0UNEQm504WqFOqUwg5SRghKnUB74rQxgsXOA
         zUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226997; x=1716831797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3D1UwEMomuBsnFm+ht0rmowgEPqEk9TJ+sRSS3dZXc=;
        b=m+ZneQ9gXAJbFw7L2RbNU/ozkECTjp6ki2bNgJERm6Flcm6Sc2C7NiYBkGLf5PndgE
         5GVEUG4R6NI/VlRTUaRceg7mA/xUsH+Ox93H8hThKhLEHupeLx/aPGNmdX0UOqECcMr+
         MGfJhcDPEJK+TWlUGKiyTGP2luGrgyq1TL7/Sgj4GNe2dY1EG/Na9D5aRUsnRHBqGfI0
         G04jj9io/7mWkdV9s/kVo8EUpM33ZV/CgS4py1ZBetrEjhmbPxtkfp2OhU40RBdsiOkh
         CyozsfTs5Uk7DbYDSMtgavqa4FLrVJyi1KLGy66WBI1UDefDRKMI1sv6MPgEHklrRWaJ
         x1/g==
X-Forwarded-Encrypted: i=1; AJvYcCXeGBEBink8ldBtCfKkHhnxziHz1KkeRjThWH2aNFK4kExKGkPKVQIynf+w52obhLofzBjbrBPzJEBoghMLE7+NQKGVI0Fx
X-Gm-Message-State: AOJu0Yxf0rIcmXOLusqHX4UjT05nqZN6oue2FtS9+4WPiJerKCnwNewz
	pNVx6FiOrxK4z5zbPcItbjcaXScjRJ3Fr08dO9OSGNua1Mwz/3iqYfeQlQbkArWJswWo4JU2qZj
	oGxNhN+173WllCnv8kxvGHFXdpJoTQeUgGnTb
X-Google-Smtp-Source: AGHT+IEJirMQYfmobtsVk911jqyrEj+MdygFnYDl/gKYLJTFeP6JhZvRtto8JCrTABhaFd8njZCwEaMuGfSWy40/YmQ=
X-Received: by 2002:a05:6402:2158:b0:573:438c:778d with SMTP id
 4fb4d7f45d1cf-5752c3f15c3mr291060a12.1.1716226996457; Mon, 20 May 2024
 10:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com> <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
 <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com> <CANn89iKPqdBWQMQMuYXDo=SBi7gjQgnBMFFnHw0BZK328HKFwA@mail.gmail.com>
 <CANn89iJQRM=j4gXo4NEZkHO=eQaqewS5S0kAs9JLpuOD_4UWyg@mail.gmail.com>
 <262f14e5-a6ca-428c-af5c-dbe677e86cb3@quicinc.com> <8ea6486e-bbb3-4b3f-b9fa-187c648019bc@quicinc.com>
 <1f7bae32-76e3-4f63-bcb8-89f6aaabc0e1@quicinc.com> <CANn89i+WsR-bB2_vAQ9t-Vnraq7r-QVt9mOZfTFY5VD7Bj2r5g@mail.gmail.com>
 <89d0b3d3-7c32-4138-8388-eab11369245f@quicinc.com> <CANn89i+YgEs1Rb4qmftmz9C-f=xKJu8AbkecNK9NCODXNQsjBA@mail.gmail.com>
 <27ddbc37-c229-4e8e-9f4f-01ca64af1d82@quicinc.com>
In-Reply-To: <27ddbc37-c229-4e8e-9f4f-01ca64af1d82@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 19:42:59 +0200
Message-ID: <CANn89iJUyBfXeSQr_QZWaQP58ZO_1c6hMe7F15sq=qYsa=TyTA@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 7:33=E2=80=AFPM Subash Abhinov Kasiviswanathan (KS)
<quic_subashab@quicinc.com> wrote:
>
> On 5/20/2024 11:20 AM, Eric Dumazet wrote:
> > On Mon, May 20, 2024 at 7:09=E2=80=AFPM Subash Abhinov Kasiviswanathan =
(KS)
> > <quic_subashab@quicinc.com> wrote:
> >>
> >> On 5/20/2024 9:12 AM, Eric Dumazet wrote:
> >>> On Sun, May 19, 2024 at 4:14=E2=80=AFAM Subash Abhinov Kasiviswanatha=
n (KS)
> >>> <quic_subashab@quicinc.com> wrote:
> >>>>>>>>>>>>> We recently noticed that a device running a 6.6.17 kernel (=
A)
> >>>>>>>>>>>>> was having
> >>>>>>>>>>>>> a slower single stream download speed compared to a device =
running
> >>>>>>>>>>>>> 6.1.57 kernel (B). The test here is over mobile radio with
> >>>>>>>>>>>>> iperf3 with
> >>>>>>>>>>>>> window size 4M from a third party server.
> >>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>> This is not fixable easily, because tp->window_clamp has been
> >>>>>>> historically abused.
> >>>>>>>
> >>>>>>> TCP_WINDOW_CLAMP socket option should have used a separate tcp so=
cket
> >>>>>>> field
> >>>>>>> to remember tp->window_clamp has been set (fixed) to a user value=
.
> >>>>>>>
> >>>>>>> Make sure you have this followup patch, dealing with applications
> >>>>>>> still needing to make TCP slow.
> >>>>>>>
> >>>>>>> commit 697a6c8cec03c2299f850fa50322641a8bf6b915
> >>>>>>> Author: Hechao Li <hli@netflix.com>
> >>>>>>> Date:   Tue Apr 9 09:43:55 2024 -0700
> >>>>>>>
> >>>>>>>        tcp: increase the default TCP scaling ratio
> >>>>> With 4M SO_RCVBUF, the receiver window scaled to ~4M. Download spee=
d
> >>>>> increased significantly but didn't match the download speed of B wi=
th 4M
> >>>>> SO_RCVBUF. Per commit description, the commit matches the behavior =
as if
> >>>>> tcp_adv_win_scale was set to 1.
> >>>>>
> >>>>> Download speed of B is higher than A for 4M SO_RCVBUF as receiver w=
indow
> >>>>> of B grew to ~6M. This is because B had tcp_adv_win_scale set to 2.
> >>>> Would the following to change to re-enable the use of sysctl
> >>>> tcp_adv_win_scale to set the initial scaling ratio be acceptable.
> >>>> Default value of tcp_adv_win_scale is 1 which corresponds to the
> >>>> existing 50% ratio.
> >>>>
> >>>> I verified with this patch on A that setting SO_RCVBUF 4M in iperf3 =
with
> >>>> tcp_adv_win_scale =3D 1 (default) scales receiver window to ~4M whil=
e
> >>>> tcp_adv_win_scale =3D 2 scales receiver window to ~6M (which matches=
 the
> >>>> behavior from B).
> >
> > I do not think we want to bring back a config option that has been
> > superseded by something
> > allowing a host to have multiple NIC, with different MTU, and multiple
> > TCP flows with various MSS.
> The default value still stays 1 and all of the accurate estimation of
> skb->len/skb->truesize still remains for all auto tuning users. I
> believe that should continue support all the configurations you mentioned=
.
>
> I merely want to add the flexibility for users which have been affected
> here due to lack of backwards compatibility (SO_RCVBUF with
> tcp_adv_win_scale value other than 1).

A sysctl is the old way, sorry.

If a fix is needed, it needs to be at the time the kernel can learn
the effective skb->len/skb->truesize ratio.

