Return-Path: <netdev+bounces-86212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6089E00E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4535E285D36
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338C13D888;
	Tue,  9 Apr 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft3qIUwH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1113D887;
	Tue,  9 Apr 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679020; cv=none; b=tN50WbgwqogjXDVo05OFt8juLzcBeLq8rxNAzlYcClRvqPxTm4ImPwBa4U5cahWEF6314kIHYv9tYp6T0Y0xQUny3Ay/cHRez2sRdog7lkYS/zli/FOnPXegb7C5EppeuqgJzueCl4vQsHEw+ZeIEy0OLumYqn+XQZ/cBT0q8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679020; c=relaxed/simple;
	bh=MSoIQx62J43Bccp2Cn+Ph43OT2HPJUyspXTcIIpIE5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be+2afMHs66ynw0Cu1EN3HVaf3FmE3P8v9Xhg2mcDXVJw04p+4i7mm8xzk8bb/ORWdVBKBAEeLjVeu0L8BKlC0ZKJ4llOqvwT21YIH0J5aiajudDgtPunng4kYe26gOnHZjHwdT+WDE3sjcE/FICVOMiSgWAkwiXty0A+BYRq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft3qIUwH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso5698254a12.2;
        Tue, 09 Apr 2024 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712679017; x=1713283817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpd1DqvxQ9ZHc8MYTvcDLh00MD3SMaBbuoB61REVNfM=;
        b=Ft3qIUwHn13pW6e0aFF58rQcfF5/JE85Hrqi9DTNzMGyqtaeK0BUNpckAa+X5JZODH
         b07b0OgWael+TFJrg+2vB6KhKjUg0Xso6jyy/fh+IkOwXqTSgbB2dFUFEqNwMBLfFGZj
         nLKTjpM9LOXk+fcFY32MraMa+bbnbDny0JLpCBYYUkFu3TGu/6PB17liVw7mStTwgMQR
         FOhW1UP4hOdqu3BSoP3gvcmW3AlRJP8Dh9faQCN66+i2LKWGZvlw3E86P0Qa0d1WHGjG
         MQy9HmT9VgeMlGMs694z9rMYnNkKSJbB1qxIKSUMerfDPV+Q2bqQ7YaDyI7MnfvA2e5I
         tyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679017; x=1713283817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpd1DqvxQ9ZHc8MYTvcDLh00MD3SMaBbuoB61REVNfM=;
        b=V0Jintb7MV5Z1jN4uwk2t+Ai2J1OfyczRLrKn17yeKhLwH6Hk7iKl9054mzH+z6EVe
         8RpGzL2z/ZmmvFUYEyIhRW39XE+VvqbAKhEg1DdnTolnpxjsxDjumZSuoP7xUJ7dyYUr
         1diwlUB6j1TKbTTZZEYLMuT5g3vpFv9rMXdADIWbh+BMsZ+8M+APX+1YcWaJ9kBftvDO
         gID50cYSC50wAPEIhzcUpIimUyXklNoAuCbKJU6cv0NuRDzgqXAu8hPp4LfIbKnSZEwD
         qeNFbvWsGtj+7RFCuqZP2n6zYjSqK4zE4X4JhlJipWbQyvpqhgeXrYuLP42ZqkJLqKpM
         uG1A==
X-Forwarded-Encrypted: i=1; AJvYcCUukJKB64ZlRNyfRnwc9l7efDzZmj+95DyY2vTTIA/Z7K06BhCuxZt068wwDZuroLlJvLG2TvUBqbWJ9Kotw1KGcwuxTMAqis8fSFmqJ4dn4bhxkNuODzFIJf6xnTCfemotGfoMxRos1l6u
X-Gm-Message-State: AOJu0Ywdy1w+5DR9Rt8tpmrgi3k0nLZ74Iek8I3RGcJ07sCGPCzx1qpL
	qzlKNlF2Sknog9Hy8+8k82y5En+aQ8kyaAZ6Zq0XjCyT897jpNPYySL2+Na5PsMfeSVuLUwcdU5
	HNe+L6R7hYd8GimlQnWvOZJSYER4=
X-Google-Smtp-Source: AGHT+IHadltt04nVaT9cOqPal59ZeRU7cfNxHDh7aWUUUOtif7ZYwxhz05jkVV2jQHMF+AZUmQoCrK4WlcZ0313LLEE=
X-Received: by 2002:a17:906:46d5:b0:a4e:cd5c:da72 with SMTP id
 k21-20020a17090646d500b00a4ecd5cda72mr6812069ejs.63.1712679016863; Tue, 09
 Apr 2024 09:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
 <20240409100934.37725-7-kerneljasonxing@gmail.com> <20240409113846.5559359a@gandalf.local.home>
In-Reply-To: <20240409113846.5559359a@gandalf.local.home>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Apr 2024 00:09:40 +0800
Message-ID: <CAL+tcoCkvNmC6iFjuG90--3jBp=VD6BfQC5LBEGr4M=SvT-aEA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] rstreason: make it work in trace world
To: Steven Rostedt <rostedt@goodmis.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, mptcp@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Tue, Apr 9, 2024 at 11:36=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue,  9 Apr 2024 18:09:34 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> >  /*
> >   * tcp event with arguments sk and skb
> > @@ -74,20 +75,38 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
> >       TP_ARGS(sk, skb)
> >  );
> >
> > +#undef FN1
> > +#define FN1(reason)  TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
> > +#undef FN2
> > +#define FN2(reason)  TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
> > +DEFINE_RST_REASON(FN1, FN1)
>
> Interesting. I've never seen the passing of the internal macros to the ma=
in
> macro before. I see that you are using it for handling both the
> SK_RST_REASON and the SK_DROP_REASON.

Yes, I want to cover two kinds of reasons and then strip them of
prefixes which can be reported to userspace.

>
> > +
> > +#undef FN1
> > +#undef FNe1
> > +#define FN1(reason)  { SK_RST_REASON_##reason, #reason },
> > +#define FNe1(reason) { SK_RST_REASON_##reason, #reason }
> > +
> > +#undef FN2
> > +#undef FNe2
> > +#define FN2(reason)  { SKB_DROP_REASON_##reason, #reason },
> > +#define FNe2(reason) { SKB_DROP_REASON_##reason, #reason }
>
> Anyway, from a tracing point of view, as it looks like it would work
> (I haven't tested it).

Sure, it works. One simple test if you're interested:
1) Apply this patchset locally
2) add 'trace_tcp_send_reset(sk, skb, [one reason])' in the receive
path, say, somewhere in the tcp_v4_rcv()

The possible result can be seen in the cover letter. I list here:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
        skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
        skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNO_SOCKET

>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

>
> -- Steve

