Return-Path: <netdev+bounces-114873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C0D94486A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8CB1C23A7C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8149D176AA4;
	Thu,  1 Aug 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+oDWmwV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663F183CA6
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504655; cv=none; b=iObEYBvlTPQ+2A+kXBKpB74o7IMh4HgrleyIs9x7BpigOofrlM23itt0iAis2lbywlgZwkId74UTr0gelEUDoZ8hCRkmaahgEDnewS43qvHEzRuHKIq8kO4OXeoJfsEX3TdeuGnriUGG9nMKAI0GOjP2JtYu8BpZATLE1G/pXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504655; c=relaxed/simple;
	bh=9k27yUTHR/1Y7t9sH2UfBxyzPXRcM9dV1q+lecVPP/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7O1f494GsMiAe9NPZRcJjVrjqCC/rnkVdS9UA2uaCLO1xKXGV06JUuEiq46Fw8weRbtZ4Dls5DIxneYaDm2whFP36Qbo+lSzd2503ZlXLeiA7BWkI2Z4g2r5rMZRMPHGkuI8lXNFwWlyomOYl2k4b/HXUFOF8W4Yc28OwlURtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+oDWmwV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so5787303a12.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722504652; x=1723109452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aGvTvKW7iy/o3QOmEbWWCsDZ0LvX5p+spHDDTQeU1Y=;
        b=D+oDWmwV+Onz9MosBNHuhW3j3yalFUN2CbxzrfytZB4XN2v135mIYRVHfVlx2oPrDA
         /nEDJVpXpLVR1jZclT3i+ruAvmagPb22ClZ/G9OeyjrgCGysV4c3dFuVTwYeoyZREGBj
         MtS33ndjpWRdrdIz/IvH6ZaBrGSfnGLGBK6T6Pv6HrLrAKnuttK6RTiH6WQAPnrAxkv8
         AIqAACOXHfhofKoXM+CiGZJdkApEvt0qFTYZ6vDMWrPLANm4fKuFrN/xBPjO6uuYaQs1
         THI/S//g9sS+uf/ud8D/a/m+MOz7kjaCZ9zNflT1mBvAJxGATFt/b+fJTXLkCKLigyDM
         8DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504652; x=1723109452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aGvTvKW7iy/o3QOmEbWWCsDZ0LvX5p+spHDDTQeU1Y=;
        b=rbpK2PfWiysBU4LdBJ54R9cN4lBxBNEVS1mg+oHQaEP+rJ6kVjFaEblEbG6hQxiaYi
         6LwkUym+qjgWGtoHtnyjw+LerLc0jLvgl4qXWa3NBKtJuPaGTRPywI89bFy2311TYc5V
         dUiAlA+YP7YqCPDo3Vbm83T0yYaOIfuVrYKwcuKvnxsB0IkDXpv7C4RR1nOAkM0h6IVF
         vvYIw3mwzEzGeEbhOgPr+Vhj4oHHNKiTr4SB5saLcV8Ja83WzGxH7KkNmtd4M8HYn+mj
         5kwhSEOuepKXbylUOMDzXJz1bSd0tUtJL913f+f9EZ9B6VrMCdUyv7ShZC/GQWxpAPN3
         ubYw==
X-Forwarded-Encrypted: i=1; AJvYcCUXYCrBOhkzBfVYro4yF21iudZlFiI0c9Iq4Nj+1RO24ST5G0rKtd9Rty6RTp+LHguU7fWqDyKAfPTwHIrkETyiAD8pKSJv
X-Gm-Message-State: AOJu0YyRdCgM63j5D0XqmV5Cn3OK5bhzbzX6/DOW098/QN8OyzTsOiF+
	XbAWpnlEg0Fzb6HcsjjZv75s3SBTDMTqCLxqppzE2TUrSWu1RNH8a0m/sA/GjsSA7j5Y0/iALZo
	8Mb3FNbWnivtuWNy39l70sj6wm/rlXw==
X-Google-Smtp-Source: AGHT+IG3e5CYN4upz6jGLNYh30tMURJ8gO1Im8gHkn8cN/fkTO/S6LbwizimQ8KCeScK+dqTxZHue6wZvOdqMaFx0RI=
X-Received: by 2002:aa7:c50e:0:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b6fbac96a4mr1216908a12.0.1722504651559; Thu, 01 Aug 2024
 02:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
 <20240731120955.23542-6-kerneljasonxing@gmail.com> <CANn89iJasXPw-k_xHRAc3uFBtbovCd0QkVBPERCzKDOTk0cM3w@mail.gmail.com>
In-Reply-To: <CANn89iJasXPw-k_xHRAc3uFBtbovCd0QkVBPERCzKDOTk0cM3w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 1 Aug 2024 17:30:14 +0800
Message-ID: <CAL+tcoAopVMG8ddjjASA6s1=6zJ6Wps3Lv5xDq+7LeCRMzGFVA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_TIMEOUT for active reset
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Thu, Aug 1, 2024 at 2:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Whether user sets TCP_USER_TIMEOUT option or not, when we find there
> > is no left chance to proceed, we will send an RST to the other side.
> >
>
> Not sure why you mention TCP_USER_TIMEOUT here.
>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v2
> > Link: https://lore.kernel.org/all/CAL+tcoB-12pUS0adK8M_=3DC97aXewYYmDA6=
rJKLXvAXEHvEsWjA@mail.gmail.com/
> > 1. correct the comment and changelog
> > ---
> >  include/net/rstreason.h | 8 ++++++++
> >  net/ipv4/tcp_timer.c    | 2 +-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > index bbf20d0bbde7..739ad1db4212 100644
> > --- a/include/net/rstreason.h
> > +++ b/include/net/rstreason.h
> > @@ -21,6 +21,7 @@
> >         FN(TCP_ABORT_ON_LINGER)         \
> >         FN(TCP_ABORT_ON_MEMORY)         \
> >         FN(TCP_STATE)                   \
> > +       FN(TCP_TIMEOUT)                 \
> >         FN(MPTCP_RST_EUNSPEC)           \
> >         FN(MPTCP_RST_EMPTCP)            \
> >         FN(MPTCP_RST_ERESOURCE)         \
> > @@ -108,6 +109,13 @@ enum sk_rst_reason {
> >          * Please see RFC 9293 for all possible reset conditions
> >          */
> >         SK_RST_REASON_TCP_STATE,
> > +       /**
> > +        * @SK_RST_REASON_TCP_TIMEOUT: time to timeout
> > +        * Whether user sets TCP_USER_TIMEOUT options or not, when we
> > +        * have already run out of all the chances, we have to reset th=
e
> > +        * connection
> > +        */
> > +       SK_RST_REASON_TCP_TIMEOUT,
> >
> >         /* Copy from include/uapi/linux/mptcp.h.
> >          * These reset fields will not be changed since they adhere to
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index 3910f6d8614e..bd403300e4c4 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -807,7 +807,7 @@ static void tcp_keepalive_timer (struct timer_list =
*t)
> >                     (user_timeout =3D=3D 0 &&
> >                     icsk->icsk_probes_out >=3D keepalive_probes(tp))) {
> >                         tcp_send_active_reset(sk, GFP_ATOMIC,
> > -                                             SK_RST_REASON_NOT_SPECIFI=
ED);
> > +                                             SK_RST_REASON_TCP_TIMEOUT=
);
> >                         tcp_write_err(sk);
> >                         goto out;
> >                 }
> > --
> > 2.37.3
> >
>
> This is more about keepalive really. You should use a better name
> reflecting that it is a keepalive timeout.

I think you're right. Let me use 'TCP_KEEPALIVE_TIMEOUT' then.

Thanks,
Jason

