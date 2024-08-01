Return-Path: <netdev+bounces-114887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB479448CF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A941C21352
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7CE16F267;
	Thu,  1 Aug 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKlWcPut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BAB183CA9
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505922; cv=none; b=dCFXMQ5Vknf1vxcjTdGZc2QCU0OT4e+uMinynwo/pSdh7ocrs1LIL6BLyGWNbzE35/wIbg8gm8HVOjEiqNJlLETQCHOM0tm4QuXrEwcnIX6RMfQlX9KmC7xTcvvdPTZzK3qnU/u2u0KUYP47a9+1N4U4CduDcbthB1XjUrFG43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505922; c=relaxed/simple;
	bh=Vr2cQ/2I2HLwx6xYh2f/L/dyFDNsFPagiiPHN8FnD/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du0Pp7j1byT4fjqQUv3MY0num+S5obMBYpJzIGhv2ncZq/7Xg+qAwXBne4GoZoN2NVIFMEdMNXwCVxi090cLj/OjmhkzuuNFyNSNzGA2qGVhp4i8mYLgrUIQxU4u1ZaTQDnLpdnnPAzTFZN8MP/2+pz0b4+JSLBU0Q/AhJ0wY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKlWcPut; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efd8807aaso10079007e87.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722505919; x=1723110719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFbrcApNN4YHdSsRURb4hSuZuW3ujmykJpfLH7b/43k=;
        b=HKlWcPuttCpKf746affdWZV9HFVuMSkizvapoPNaxFo4FmXLoFRHRsctMNTjVIRQad
         SIcw+ZFEi6N5c/1bqhKJyNyJ04MNaJMZQO20X2hCf726iySTPPOn2Qp5e2WPU6S6vRCX
         MBdfeX8xD6TPT9knkYuHONQBhvL5uGq8gu/9852JwkitdDgfOBEVzkSvpJgD9SWJg5k1
         daG/1vFDnuXKfXpuum48FaWxa1Re1G5T4X+q52uwMMjCLz3vG6x5UpJWmJliFqFS/NO7
         4xq50WuTNMFZ/RqUNZxZ+YYUMzAOkLuZ82koDKxBMhIFItWv3jofzIWFemKAYFvTUFcn
         G6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505919; x=1723110719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFbrcApNN4YHdSsRURb4hSuZuW3ujmykJpfLH7b/43k=;
        b=pivnhFYvQOVf8jfSt/soTNbC894o3ZzgmeNVHI4a/KwnOK/2x84nz5dW96ZKRAZbSw
         euMBWIXj1zl6v3UCvDS823tI2nI69PQCbVkv6urm+V7+I3/ATk43Jib986pthmqQQmcr
         n187wGN+RZDrwNde2vGPs/ZGKFtXuHc4xMz4vYCO01B73g3arS85O5WUWpHqUSpZxD3F
         vbbNqhPV9TQoYO3qtEBMI3SGGw4IUE3nUAhfONmXbnJf7QHup0QaiO/l/o/ATgU84zO7
         V+LKUy4Bn8Ab+lBMxyHOt8909glCg57AjO06kLR1TVbrwUnkzQ8WqSxHswzR42wE8Mo3
         lNZg==
X-Forwarded-Encrypted: i=1; AJvYcCWRoRMnyZ3200CVaBfdgxMyZCXTLJX7WUwgzEwf5XrM1ch/aac1iyqC6oxTp55Oc4Nxz87MURGkEhLH63P6Mlrjkke2auzX
X-Gm-Message-State: AOJu0YxzYOY4bvxhMynglOPU2ihCCWQYWJY0LQcXknT8fMIXBzWLwzxB
	lRM95AV9YP9tmmrjgDuNPn9LVkERw6zVBN1CFlGA1P1ItiQqAuh7Faj/j2y0N6eciZoaR2WXH2u
	rn2eQQV81W/F2D33sQyc/ZNJKri4=
X-Google-Smtp-Source: AGHT+IH7oOKjbsc7sQziDfdvAnNUernoYEcsmMSrSA9IohhSehmWUlQsryJkKYlbq5Dp92s3MAgUm7CjWvTXDdc2R9w=
X-Received: by 2002:ac2:46f0:0:b0:52e:f907:1023 with SMTP id
 2adb3069b0e04-530b61f36c2mr1075003e87.49.1722505918149; Thu, 01 Aug 2024
 02:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
 <20240731120955.23542-5-kerneljasonxing@gmail.com> <CANn89iJGco0f2RLBm4bW3QpRHwscwZhc287RX+mWA0Q_=hfTYA@mail.gmail.com>
In-Reply-To: <CANn89iJGco0f2RLBm4bW3QpRHwscwZhc287RX+mWA0Q_=hfTYA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 1 Aug 2024 17:51:20 +0800
Message-ID: <CAL+tcoD5OK6usHhJUGLn0WogBxVDJV8HF209ZBkd=xNLP34SfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_STATE for active reset
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Thu, Aug 1, 2024 at 2:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introducing a new type TCP_STATE to handle some reset conditions
> > appearing in RFC 793 due to its socket state. Actually, we can look
> > into RFC 9293 which has no discrepancy about this part.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > V2
> > Link: https://lore.kernel.org/all/20240730200633.93761-1-kuniyu@amazon.=
com/
> > 1. use RFC 9293 instead of RFC 793 which is too old (Kuniyuki)
> > ---
> >  include/net/rstreason.h | 6 ++++++
> >  net/ipv4/tcp.c          | 4 ++--
> >  net/ipv4/tcp_timer.c    | 2 +-
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > index eef658da8952..bbf20d0bbde7 100644
> > --- a/include/net/rstreason.h
> > +++ b/include/net/rstreason.h
> > @@ -20,6 +20,7 @@
> >         FN(TCP_ABORT_ON_CLOSE)          \
> >         FN(TCP_ABORT_ON_LINGER)         \
> >         FN(TCP_ABORT_ON_MEMORY)         \
> > +       FN(TCP_STATE)                   \
> >         FN(MPTCP_RST_EUNSPEC)           \
> >         FN(MPTCP_RST_EMPTCP)            \
> >         FN(MPTCP_RST_ERESOURCE)         \
> > @@ -102,6 +103,11 @@ enum sk_rst_reason {
> >          * corresponding to LINUX_MIB_TCPABORTONMEMORY
> >          */
> >         SK_RST_REASON_TCP_ABORT_ON_MEMORY,
> > +       /**
> > +        * @SK_RST_REASON_TCP_STATE: abort on tcp state
> > +        * Please see RFC 9293 for all possible reset conditions
> > +        */
> > +       SK_RST_REASON_TCP_STATE,
> >
> >         /* Copy from include/uapi/linux/mptcp.h.
> >          * These reset fields will not be changed since they adhere to
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index fd928c447ce8..64a49cb714e1 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -3031,7 +3031,7 @@ int tcp_disconnect(struct sock *sk, int flags)
> >                 /* The last check adjusts for discrepancy of Linux wrt.=
 RFC
> >                  * states
> >                  */
> > -               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_=
SPECIFIED);
> > +               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_=
STATE);
>
> I disagree with this. tcp_disconnect() is initiated by the user.
>
> You are conflating two possible conditions :
>
> 1) tcp_need_reset(old_state)

For this one, I can keep the TCP_STATE reason, right?

> 2) (tp->snd_nxt !=3D tp->write_seq && (1 << old_state) & (TCPF_CLOSING |
> TCPF_LAST_ACK)))
>

For this one, I wonder if I need to separate this condition with
'tcp_need_reset()' and put it into another 'else-if' branch?
I decided to name it as 'CLOSE_WITH_DATA' because it can reflect that
the write queue of the socket is not empty (at this time the user may
think he has more data to send) but it stays in the active close
state.
How about it?

Thanks,
Jason

