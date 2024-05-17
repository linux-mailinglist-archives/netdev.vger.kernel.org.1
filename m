Return-Path: <netdev+bounces-97013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401A8C8BB8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E874A1F26F1F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371213FD81;
	Fri, 17 May 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeKgtU4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28413DDB8
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967725; cv=none; b=IzvpELaUu21FH2L9TmN3IbsXZwaO5EAgkJ8xMEniEm/h5gCq7yJOdMu8pKfxqs1Clq+ibo+V1mLXK881EiUEOCOUZxwT0Kowk3PcpUOq2/EcvrA0wVwmq/2o59XAbRNQlyhPD1+JWsu/kWrwJWrc1dM8zq6i6UsYxi16gYF4FcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967725; c=relaxed/simple;
	bh=5QeAGVqJ7W3aoZIE++lakURa7P8gNVoR3o0ogkSFHoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFZpEwlmA/lcx2WjSgb15IoXxE+QDduZmoNdfUH1bWM50oXrDb5Trwi30C41zy0m6GS36YdTwIqo+dCL80HoyVOg9ESop95CIWI88SehogGynPR9Z+G9N1rl417zNUV2Fr3nMpNXxCUwWwV8kBwDGDuQCfsvf4yRiz7iUDnE0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeKgtU4L; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso5215359a12.3
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715967721; x=1716572521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4rYaEngacx14vokUawF+ysGnO+JctpmOl20s+EzcGg=;
        b=NeKgtU4LOHU0+5UnoSbJPcg7ZfalkWKJM/m3caZaU1YRvdH9pGju6usB0eAmtzw3qv
         YBLg2rgDMszeD5vWuNJbnvZrRpZOG1gCPb9bBY6hIx6cg8q8BHtAtyVc88YMxbhh6ZUG
         2brhrvQCoY4mCwqCnRheRheRWIJ2yHGyjWR6y0Mw2VjgqOQlpLXFFdhtRACGRV8qmekD
         T/XXUQrOWakiOyfE2UDD4XH6bH20bXeB2wrx+MIdW7YAC0j08y4nILcaOF7V3eBrWNnG
         ucsxMpmTKPNsnhcgR9XDnQTIotU1hKhCQ2Nk8SFoqB/hs1A76gWX9cYJUDIs4X3Fd/Ci
         1lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967721; x=1716572521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4rYaEngacx14vokUawF+ysGnO+JctpmOl20s+EzcGg=;
        b=gtQl5NE2nRgHmE6Q+gYC3fg/Mv3oUga/m0X4kfX9IQtceVZcSL4dmaOHwAiXLOfK0I
         ung6gniQJGH8NUX1LjgSQRBPHXX5+FYNXWYdtzE50XfP6ybKdex0M/Jj7Kzl+KOHIpqd
         N4MknCesUR9e4+0xjZ1bzWOwsgPfCSKUb9wppq46mBDoYa3tkGTRW2aeAmEMZGu30d0G
         EJcI3XGCKBztin4gwXTv3uGdknhHHRjBHt3yJAbdFwlBO3Eli5bOlzTLBLY0KJr9cgek
         xGfGca/gwBAaiUiWgIxaMx9F4r6ESJypsoiwfycolVIrhXLsFkvl/zjgR/56QWzEurgO
         EH0g==
X-Forwarded-Encrypted: i=1; AJvYcCWi/nBkLG6h4HNY/ZfB7Py8OY4rjmc/f+7F3slEQekM6z63mNeGfJyNO/EaetOnhQqlpKriUWJnCK+/9JUWc42PNcr+mFVY
X-Gm-Message-State: AOJu0YxGkEq0P926eKVnPU8B0BVJgU220bHesIQqDzdT/zEbzzHdMbEW
	VGT4IVmbDiCpFnDD6mZY8y3gfoqAve2grMxArWthhtrDf8CBDN+BBgWEvw8h2iYtug3rAv+vXMs
	xbcZMZs6sAzoVPX4VsYpJkd62MwQ=
X-Google-Smtp-Source: AGHT+IFZqMuqnIEoTFqMm1xpapvpyg53lXzWB6Esl5KuDi5IJSnYymac65uAq4iSl9Hqs3gbmDneU55IxZa44NDArzQ=
X-Received: by 2002:a17:907:3203:b0:a59:b8e2:a0c5 with SMTP id
 a640c23a62f3a-a5a2d66b509mr1971177666b.51.1715967720785; Fri, 17 May 2024
 10:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517085031.18896-1-kerneljasonxing@gmail.com> <CADVnQymvBSUFcc307N_geXgosJgnrx4nziFcpnX-=jU7PronwA@mail.gmail.com>
In-Reply-To: <CADVnQymvBSUFcc307N_geXgosJgnrx4nziFcpnX-=jU7PronwA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 18 May 2024 01:41:23 +0800
Message-ID: <CAL+tcoDbB2if_=h7XSRU9_i2G=xT+fqmxCU-Mhe438PYcqxj-w@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: break the limitation of initial receive window
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 10:42=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Fri, May 17, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Since in 2018 one commit a337531b942b ("tcp: up initial rmem to 128KB a=
nd
> > SYN rwin to around 64KB") limited received window within 65535, most CD=
N
> > team would not benefit from this change because they cannot have a larg=
e
> > window to receive a big packet one time especially in long RTT.
> >
> > According to RFC 7323, it says:
> >   "The maximum receive window, and therefore the scale factor, is
> >    determined by the maximum receive buffer space."
> >
> > So we can get rid of this 64k limitation and let the window be tunable =
if
> > the user wants to do it within the control of buffer space. Then many
> > companies, I believe, can have the same behaviour as old days. Besides,
> > there are many papers conducting various interesting experiments which
> > have something to do with this window and show good outputs in some cas=
es.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp_output.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 95caf8aaa8be..95618d0e78e4 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock *s=
k, int __space, __u32 mss,
> >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_w=
indows))
> >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> >         else
> > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> > +               (*rcv_wnd) =3D space;
>
> Hmm, has this patch been tested? This doesn't look like it would work.

Hello Neal,

Thanks for the comment.

Sure, I provided such a patch a few months ago which has been tested
in production for the customers.

One example of using a much bigger initial receive window:
client   ---window=3D65535---> server
client   <---window=3D14600----  server
client   ---window=3D175616---> server

Then the client could send more data than before in fewer rtt.

Above is the output of tcpdump.

Oh, I just found a similar case:
https://lore.kernel.org/all/20220213040545.365600-1-tilan7663@gmail.com/

Before this, I always believed I'm not the only one who had such an issue.

>
> Please note that RFC 7323 says in
> https://datatracker.ietf.org/doc/html/rfc7323#section-2.2 :
>
>    The window field in a segment where the SYN bit is set (i.e., a <SYN>
>    or <SYN,ACK>) MUST NOT be scaled.
>
> Since the receive window field in a SYN is unscaled, that means the
> TCP wire protocol has no way to convey a receive window in the SYN
> that is bigger than 64KBytes.
>
> That is why this code places a limit of U16_MAX on the value here.
>
> If you want to advertise a bigger receive window in the SYN, you'll

No. It's not my original intention.

For SYN packet itself is limited in the __tcp_transmit_skb() as below:

    th->window      =3D htons(min(tp->rcv_wnd, 65535U));

> need to define a new TCP option type, and write an IETF Internet Draft
> and/or RFC standardizing the new option.
>
> If you would like to, instead, submit a patch with a comment
> explaining that this U16_MAX limit is inherent in the RFC 7323 wire
> protocol specification, that could make sense.

I quoted from that link:
--------
    I'm not trying to make the sender to send more than 64Kib in the
first RTT. The change will only make the sender to send more starting
on the second RTT(after first ack received on the data). Instead of
having the rcv_wnd to grow from 64Kib, the rcv_wnd can start from a
much larger base value.

    Without the patch:

    RTT:                                1,                   2,
    3,  ...
    rcv_wnd:                64KiB,        192KiB,         576KiB,  ...

    With the patch (assume rcv_wnd is set to 512KiB):

    RTT:                                1,                    2,
     3,   ...
   rcv_wnd:                64KiB,    1.536MiB,    4.608MiB,  ...
--------

Another quotation from the paper [1] which has been deployed in Yahoo:
"By increasing this ICW, small objects stand to be transferred in
fewer RTTs, which when compounded across all objects on a page can cut
down the total page load time significantly.
...
Luckily, on popular operating systems (except Linux which has a much
smaller receive window), the initial receive window is quite large
(64KB-256KB), which would allow for utilizing a larger ICW"

[1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf

Thanks,
Jason

>
> best regards,
> neal

