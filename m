Return-Path: <netdev+bounces-88214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466F8A6563
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D757B221C6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0C8665B;
	Tue, 16 Apr 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDoMeJnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165ED84FDE
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253573; cv=none; b=F4EFzYMYgfHVp2soRJjprZ06irBLTQgm75mrZcETGDVvrTAv2naj7ZOgcWA0ADo4Mn7SsBm8KBqsLzJYMCWCzmOE3QAz6Ww1h+leQdUxcrLhhWcxUt+XrzmMAMm9sskplT1eg5Ic0T/AFzTFVfZKcv2nO9egaEHeEDIuv2gxswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253573; c=relaxed/simple;
	bh=vk6JfY8qrQ5jCabF1GPxdPSeYWAPJTS6S6pluDj/nQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc7Yqd4m52urFrOiMkI/sQJ9VktPf1/nqV+Zox5RZOn4F5ZVwLaDVP+W0/bhT99va74PWJVU75VVLk/zzcelzr0232kzmuItV2GN01xokGcCmuxxtYEjoXTfcMaEa+axwluZavOOA2FOoZDal5nDQiish7kQP5y4JDcmOW+w5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDoMeJnR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5200afe39eso501218366b.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253570; x=1713858370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlc9OAtPyGThuRreoHGGq4JhsMFG7UIHgTXexs1GEKI=;
        b=CDoMeJnRCjWeDAU/EHk83eNHd5foo+IB7nVAyFP6n0FjIsRvwzWrND7oMc/9aJtV62
         aI25FddxyN1C6ctYdT031Twc00OdAiO2upBtUuk6i9lzmKVW/lnrtiUwfzTKOCDkWXKp
         RDhUJ0Ougs+YPDy45hJAWyn8oLDsgvPQWwP02anUxFBBQBaF6SEQ6CtZ53u0jfT9Fzx+
         8VKps+6V5DNJ5+hi084jBdlUm0gg3rqPgWqeuAGjt6MSNZ9i/9Dq1wmMFArLmOQ/2W6Z
         4Jo8o8GXibNL/2Wcjuq85Jox4KDmkNIIZUMYD7Ic6OVs/zFrPzF+x+n9RLu1g5tDDZaf
         xnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253570; x=1713858370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlc9OAtPyGThuRreoHGGq4JhsMFG7UIHgTXexs1GEKI=;
        b=qJqEILpwGkKnIWpKJ0VGiCR7zKu0YxZgE7LZlyz64ONGnDA7k+JXgbmm2C0vzPsZCY
         OHNM/Xo8rRe84tNgMSgqph0iCM8ZNIMVmQQOdiv1MmmLIvsNm52h4GIrsGRhk5eJNDVe
         3mlX2BZ/shKSprZgRnB3CSDBC370cd3HkmVg7DVcDNhVSFjwJJ8Nhgg1pb9kyIFbGsqw
         i8G6WRSMXk9XpJa94CpMO2h+T260nRg2bkBP7A4q1dh/HXEKd05f45y7cz9HAeTDwnoX
         uQRmvU6ggaAqWw/JZPej4iiRF294cRnLJPzz0lZsUJ69affmAsZLh6koiShwKr5W2NhE
         zvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJJAzQ4ab+tbl+4FGED4kwl5pxaC0IK+bHOAFA+VjjMg6voknZT7mmJAPP+MZd3B3N0eKRK7It3Dh53TtswDQoJMsdbdyM
X-Gm-Message-State: AOJu0Yzt+E+BsDZwmLaMN31NVTMdfkLpekdNOZZQKtdkYPIfUKaQCt6Y
	CMtdcRnxL0nRk3izFJBIe1StfCoOoPa2i2fZHAEcU9ecn9WtrJaTVXGsBlLjCYa1nxOorXjDB2V
	trpCC6PuY++1R69LCuSI7m33R9GI=
X-Google-Smtp-Source: AGHT+IE+FjE3cfbMa11xSLAJqaup16gjkKCR1tUG07Qz1Ezru8a1zyUIoXUCVjxkyGQXJdp//WqMt/G70qfTGvg9+IM=
X-Received: by 2002:a17:906:1290:b0:a51:c964:3cb7 with SMTP id
 k16-20020a170906129000b00a51c9643cb7mr8240923ejb.61.1713253570188; Tue, 16
 Apr 2024 00:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-6-kerneljasonxing@gmail.com> <CANn89iKf7yOUY9XA3M+Sbxhit5grH0PtJ8qyJt5gJHNaS7EHVQ@mail.gmail.com>
In-Reply-To: <CANn89iKf7yOUY9XA3M+Sbxhit5grH0PtJ8qyJt5gJHNaS7EHVQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 15:45:33 +0800
Message-ID: <CAL+tcoAA+X3HTj5Lvir5vVzTbGMZzKx_tCw1z46uaxj8iYuOYw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It relys on what reset options in the skb are as rfc8684 says. Reusing
> > this logic can save us much energy. This patch replaces most of the pri=
or
> > NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/mptcp/subflow.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index ba0a252c113f..25eaad94cb79 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(cons=
t struct sock *sk,
> >                 return dst;
> >
> >         dst_release(dst);
> > -       if (!req->syncookie)
> > -               tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_=
NOT_SPECIFIED);
> > +       if (!req->syncookie) {
> > +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> > +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpex=
t->reset_reason);
> > +
> > +               tcp_request_sock_ops.send_reset(sk, skb, reason);
> > +       }
> >         return NULL;
> >  }
> >
> > @@ -375,8 +379,12 @@ static struct dst_entry *subflow_v6_route_req(cons=
t struct sock *sk,
> >                 return dst;
> >
> >         dst_release(dst);
> > -       if (!req->syncookie)
> > -               tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON=
_NOT_SPECIFIED);
> > +       if (!req->syncookie) {
> > +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> > +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpex=
t->reset_reason);
> > +
> > +               tcp6_request_sock_ops.send_reset(sk, skb, reason);
> > +       }
> >         return NULL;
> >  }
> >  #endif
> > @@ -783,6 +791,7 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >         bool fallback, fallback_is_fatal;
> >         struct mptcp_sock *owner;
> >         struct sock *child;
> > +       enum sk_rst_reason reason;
>
> reverse xmas tree ?

Got it. Thanks!

>
> >
> >         pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, l=
istener->conn);
> >
> > @@ -911,7 +920,8 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >         tcp_rsk(req)->drop_req =3D true;
> >         inet_csk_prepare_for_destroy_sock(child);
> >         tcp_done(child);
> > -       req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > +       reason =3D convert_mptcp_reason(mptcp_get_ext(skb)->reset_reaso=
n);
> > +       req->rsk_ops->send_reset(sk, skb, reason);
> >
> >         /* The last child reference will be released by the caller */
> >         return child;
> > --
> > 2.37.3
> >

