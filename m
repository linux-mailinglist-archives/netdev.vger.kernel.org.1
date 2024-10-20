Return-Path: <netdev+bounces-137307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9D9A553B
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F538280ABC
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BAC7462;
	Sun, 20 Oct 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL4Ojdo7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AE2119
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442111; cv=none; b=qzNIaXD4+q+tkcEDZBl7X/FR6W6xAtG8pV0z+OUgLiv4YweibPh646Bz2VhRCAinOzHazlGH5+eGqjLunBFlzdsC4DzES5Zs3T/KEKgZ4HT+pOUlEnYgztRO60bx2bU6GXJXgkthtNBD2K22VvUy5I9SquYg3yTj9pzVH2tZob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442111; c=relaxed/simple;
	bh=yWrS12YhcJSA/gxWJufntU13G3L7O3X6/jBQ5PM2Euo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hldhqv2CawRQySsOxCZl6QIcAvXyASoEWvt75nfEXAngJ1IbeuDV29aO9tz/vX9xv1lf87WMCdA37WkeheqiA8rm8nYswy4lDErdZADf5PBlKIcjucL0raFAmH6jFdqpa/yq8Wga/VWy2irX+uWGoGB793gLaqawI1yY364sP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL4Ojdo7; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3a6abcbf1so14712525ab.2
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729442108; x=1730046908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njJgZdwO0Va/jsZWkum9HwwQUvi0tNjsGS3ty1skwOg=;
        b=UL4Ojdo740eMSFDLHBk56/MxLpW+KD1DT9DeQkVTbf4yk4ztvHMd2LB0NcsCdo1o7b
         /iQwHX8EkDNbqlXJ07Yo1x4WRexBmPm9OYt5+kKmHkcXWgwYKLl4c3fGuLa7EZpfghdy
         XrtYEZPQOwjnr4LSQnj+X20pR99CW5Nn1T4Cts32LjHMg0q6E2d82nz4KLggNWNGEwoq
         oS1HHn6HsrSGY4Ctk1FySYyJQPwTncRZtCgnKN1kAx1h1d7KaWbDcQJhTjTe1wdAwltX
         zKaWxr8i3KmL80qEUoewmlDIMPAeph8nkIwzip7tXWstf2+BxaF73bk1FGAGr7wNIOnG
         MZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729442108; x=1730046908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njJgZdwO0Va/jsZWkum9HwwQUvi0tNjsGS3ty1skwOg=;
        b=fNLQ/V2Jd9YO8fE1iJRey9fUo3v3YI7+K8BVFMwN8SsthOt4TpLZcBYYJiAclEJQkM
         e6jSX5TgOojeO6AN8sDikXw8KnsnZRTfuGBkxg38+yHt0FDBrtg64ntEaHaw/hkpBKe1
         Z4iYMYOfzAWMG94gu4ntgOIdNsm4nnfjdm+HZuhmDsW6ji4FQCEZSw7iFE7fNNvWpLjf
         Wuc9xxGMA63QPWPDHWRGNMr6NUF3KtPj0mXaZECJt7Ca1r9igExOJFvJX3ZqFtiUka3B
         hFh2F5F1tQZsvggsa9R0xF5lKo9coUxf12JIGuR+oUJcoMTLDf/Or6fEmlsQ7PCNSRYN
         ro6g==
X-Forwarded-Encrypted: i=1; AJvYcCURvf6o2sDS14Af+uuqludNHj1/112XGCUKiaSEAG9SluTHyifxKzggI0QxFFtmfTYvZ6744GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlyPex/i9TZKRDJsMF55rBjyW30LOywdmk/88fJDr8rYLdAt4
	c4P66bQASjo4wPPE4y5gCceIHwnosJkTxipatfgUCkXqhIjUns0zshZVTJasHovM9avvDlaSEhM
	X/hE63VjF7qeyGymMvZoPgIh7dW4=
X-Google-Smtp-Source: AGHT+IEM2krg+KgJqXMQX8DusVGuA6EhwS+lq8rdNER81XHR/Wm3ua/2YjF/jpH9q52s/hYVPMoJ5QWfRvJNYOW+g2I=
X-Received: by 2002:a05:6e02:13a7:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a3f3fd2d19mr81852735ab.0.1729442107983; Sun, 20 Oct 2024
 09:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020145029.27725-1-kerneljasonxing@gmail.com>
 <20241020145029.27725-2-kerneljasonxing@gmail.com> <38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org>
In-Reply-To: <38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 00:34:31 +0800
Message-ID: <CAL+tcoByVRMTt5r1WPN8ovwQDW0fO-ksWya-MCMw2v_93DOCLQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add a common helper to debug the
 underlying issue
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello David,

On Mon, Oct 21, 2024 at 12:18=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 10/20/24 8:50 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Following the commit c8770db2d544 ("tcp: check skb is non-NULL
> > in tcp_rto_delta_us()"), we decided to add a helper so that it's
> > easier to get verbose warning on either cases.
> >
> > Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@=
redhat.com/
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > ---
> >  include/net/tcp.h | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 739a9fb83d0c..cac7bbff61ce 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2430,6 +2430,22 @@ void tcp_plb_update_state(const struct sock *sk,=
 struct tcp_plb_state *plb,
> >  void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
> >  void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_sta=
te *plb);
> >
> > +static inline void tcp_warn_once(const struct sock *sk, bool cond, con=
st char *str)
> > +{
> > +     WARN_ONCE(cond,
> > +               "%s"
> > +               "out:%u sacked:%u lost:%u retrans:%u "
> > +               "tlp_high_seq:%u sk_state:%u ca_state:%u "
> > +               "advmss:%u mss_cache:%u pmtu:%u\n",
>
> format lines should not be split across lines. Yes, I realize the
> existing code is, but since you are moving it and making changes to it
> this can be fixed as well.

Thanks for reminding me. Actually before submitting this series, I
noticed this warning. I was thinking it looks a little ugly if we are
going to add more information in this function?

This function could be like this:
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..8b8d94bb1746 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2430,6 +2430,19 @@ void tcp_plb_update_state(const struct sock
*sk, struct tcp_plb_state *plb,
 void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
 void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *=
plb);

+static inline void tcp_warn_once(const struct sock *sk, bool cond,
const char *str)
+{
+       WARN_ONCE(cond,
+                 "%sout:%u sacked:%u lost:%u retrans:%u
tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u
pmtu:%u\n",
+                 str,
+                 tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
+                 tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
+                 tcp_sk(sk)->tlp_high_seq, sk->sk_state,
+                 inet_csk(sk)->icsk_ca_state,
+                 tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
+                 inet_csk(sk)->icsk_pmtu_cookie);
+}
+
That quoted line seems a little long... Do you think this format is
fine with you? If so, I will adjust it in the next version.

Thanks,
Jason

