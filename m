Return-Path: <netdev+bounces-123373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3909964A36
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321811C22C57
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5191B2505;
	Thu, 29 Aug 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzPH09rb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5043A1B5
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945949; cv=none; b=ZHlJulS3bjKI9LqqZunXh8Rpwp+X3oeIxHVHX37Ngr0C5BlCtclxjEEdKRZGLJSLiQdAwZ/7Xp3UTfKBiH/WO5B8Gl0J6g3Mn30+7No2rEZuvFWX9DxXUMSXd8/gsNuJ9mQ5KbFOEkI9l8fj70FUnBHCQ4CMlRVPNHbHcPTUBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945949; c=relaxed/simple;
	bh=U62SgozeqwXD2uP7uBrzNqg4wblJZH8FxQK213wtmCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJg2aHMlGsPq5fYBAnrUr0ZSjmdjDGaaYb1AycrgeHBded1jcKp+wbrzMZUeISCU4F64fE0RElSxsQsJ2BmVEhxYIZcaTW7d5r6Tni0ggUP/Vse+2JWg0DGJ0GhSVlf8k9hWJY0powdg1OojWn5QljSwO2vBimJvsC20WqrUfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzPH09rb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8692bbec79so96734666b.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724945946; x=1725550746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EDWTVKotRJ3uxY2VwcINZ9wLlWfG8f2AGB7KFhnpdY=;
        b=PzPH09rbjZlYKHYIaoSWDBQfdrxguno0S99WbqoPVYYNsBqVttWVCpeLXPvAC2XtkF
         h1/XjOx4AZokO+QXh23WymTn0HWNYHdgMLubz9bF2e4p6kWSCDE4NE7Oxdh2yu8ZMmML
         YPFRzoV+pSemr0VXjuiZWvUFRmDdqQbGW3efw60DZHdgM8Erd7Ln+AK475j22dZKe9+t
         exf8Xon9jyXfUXGl1iwWE/WHwysFIk3m5DbmHBm6iL0jh536uLejqs7odQdIJL/FCJ3e
         SN37nGyNl5Tms+hqQITtm5aX3esArkwxAgiMOyohOSM547wbExcqf7Ygt3uyJpB5Xxtp
         P+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945946; x=1725550746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EDWTVKotRJ3uxY2VwcINZ9wLlWfG8f2AGB7KFhnpdY=;
        b=ENjwPfPMmYH8gFAg8DSJzXS7iSHaq7/bcCCS4F9cNly82nWBug/q2q74FHr68z5UIJ
         CACPk6VsBwON66jY35nu0XEpiO6ijQTi/n/2dMnbJgV8N+GXlg4Dwas9IUtaTxWYf2F8
         9lbse0SaREVHUyOk3bq2zoImarpg46laq0t6CAgcasSfqL/nVyJsKPOShOKd6EZaAhbX
         FRrIEZQyChSu1OaAp/oLOWDon0ok0okphv3JRWhQpXb+hsdYLbyqNipzElJ1zrr+K27z
         sCxUdQFX0os1cnFm7w6JH1klvBu4nnPt0t5aWb/oskV85Vz3h9TxsIs1Hc/yutOtjw2/
         l+aA==
X-Forwarded-Encrypted: i=1; AJvYcCXWW2G8SRpmCWF9dmFjnBuFul6m2hC7Dxz1zl+w0VapdYYFuVxAw+JemCQEnn47L2B1meZsaMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yNgc5bH0ac4VxFaN+J28e/EhC6vy8vdB3yXfEzoOM4j5W5+W
	V5lEaCVF1r1QmewbotEa6eeHaivh/VlzKu3BIUYn+vftIP+FyHeHY/n+JQWkb8tWMD7sGtoTNK0
	y0Yb3Wy2g0FkHV6tywvIBOlIf6W4=
X-Google-Smtp-Source: AGHT+IELmvZIrQ4amu2xaIbl6UOjB/kAkiAxuQbGk7XtRT5bxb47nWvEbzMKK8M3HelDUB10ZfSRWZUSYbPGZYtPz7Q=
X-Received: by 2002:a17:907:e86:b0:a86:aee7:9736 with SMTP id
 a640c23a62f3a-a897fa755b3mr266452566b.46.1724945946155; Thu, 29 Aug 2024
 08:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <20240828160145.68805-3-kerneljasonxing@gmail.com> <66d083d24aa8c_3895fa294d5@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d083d24aa8c_3895fa294d5@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 29 Aug 2024 23:38:27 +0800
Message-ID: <CAL+tcoBby-AfrjFB8cAj5qcVK2T45=q61f3Y+W9_KfQQdVa0Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:21=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like the previous patch in this series, we need to make sure that
> > we both set SOF_TIMESTAMPING_SOFTWARE and SOF_TIMESTAMPING_RX_SOFTWARE
> > flags together so that we can let the user parse the rx timestamp.
> >
> > One more important and special thing is that we should take care of
> > errqueue recv path because we rely on errqueue to get our timestamps
> > for sendmsg(). Or else, If the user wants to read when setting
> > SOF_TIMESTAMPING_TX_ACK, something like this, we cannot get timestamps,
> > for example, in TCP case. So we should consider those
> > SOF_TIMESTAMPING_TX_* flags.
> >
> > After this patch, we are able to pass the testcase 6 for IP and UDP
> > cases when running ./rxtimestamp binary.
> >
> > Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  Documentation/networking/timestamping.rst |  7 +++++++
> >  include/net/sock.h                        |  7 ++++---
> >  net/bluetooth/hci_sock.c                  |  4 ++--
> >  net/core/sock.c                           |  2 +-
> >  net/ipv4/ip_sockglue.c                    |  2 +-
> >  net/ipv4/ping.c                           |  2 +-
> >  net/ipv6/datagram.c                       |  4 ++--
> >  net/l2tp/l2tp_ip.c                        |  2 +-
> >  net/l2tp/l2tp_ip6.c                       |  2 +-
> >  net/nfc/llcp_sock.c                       |  2 +-
> >  net/rxrpc/recvmsg.c                       |  2 +-
> >  net/socket.c                              | 11 ++++++++---
> >  net/unix/af_unix.c                        |  2 +-
> >  13 files changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/=
networking/timestamping.rst
> > index 5e93cd71f99f..93378b78c6dd 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -160,6 +160,13 @@ SOF_TIMESTAMPING_RAW_HARDWARE:
> >    Report hardware timestamps as generated by
> >    SOF_TIMESTAMPING_TX_HARDWARE when available.
> >
> > +Please note: previously, if an application starts first which turns on
> > +netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SO=
FTWARE
> > +could also get rx timestamp. Now we handle this case and will not get
> > +rx timestamp under this circumstance. We encourage that for each socke=
t
> > +we should use the SOF_TIMESTAMPING_RX_SOFTWARE generation flag to time
> > +stamp the skb and use SOF_TIMESTAMPING_SOFTWARE report flag to tell
> > +the application.
>
> Don't mention previously. Readers will not be aware of when this
> Documentation was added.

Got it, I will remove it :)

>
> Also, nit: no "Please note". Else every paragraph can start with that,
> as each statement should be noteworthy.

I see.

>
> >
> >  1.3.3 Timestamp Options
> >  ^^^^^^^^^^^^^^^^^^^^^^^
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index cce23ac4d514..b8535692f340 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2600,12 +2600,13 @@ static inline void sock_write_timestamp(struct =
sock *sk, ktime_t kt)
> >  }
> >
> >  void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> > -                        struct sk_buff *skb);
> > +                        struct sk_buff *skb, bool errqueue);
> >  void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
> >                            struct sk_buff *skb);
>
> I suspect that the direction, ingress or egress, and thus whether the
> timestamp is to be queued on the error queue or not, can be inferred
> without exceptions from skb->pkt_type =3D=3D PACKET_OUTGOING.
>
> That would avoid all this boilerplate argument passing.

Ah, good suggestions!! I will update it in the V3.

Thanks,
Jason

