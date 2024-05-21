Return-Path: <netdev+bounces-97261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B78CA57E
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 02:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0635C28268E
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F081E;
	Tue, 21 May 2024 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT5VYxwF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63925EEB9
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253138; cv=none; b=qT7DCDtZ8AdU4esZsyNFFfkRBY33qawnNsws2AecEoRBWnD4FDoyZ52DyLuOHVbJQKtpPz3eK+YDzNMulhmTAPSD4EDYh5YaV8gKpSj3LnkXudpBCaS6JS1A4UO/snY64xCiTNxP4nC5arom+ozD+gwdjweecn3GJX9mFbD8lck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253138; c=relaxed/simple;
	bh=T8iO8orOWfA7/sGNRmKaqM3t2hxhLFqWK6Y8hren2Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOO/EZyXadTXZZWAvWVENUOSZNKdPZtBJ2LyTQVPVaEwNhcoQPGzaQbjkL4h1MIc+GHxHuAFnFrNjNpJKrHnNi8A65qDZyb2+QjTgwyv7hjfweVRqKO8/wKEgw6gR+8pzJdf/U6z3OBWbfMHOGP6trcucxI42eahnqBcvcpKdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT5VYxwF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so9011101a12.2
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 17:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716253135; x=1716857935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRUqZNfKo3bno7MhWC76z2IUcSm6kViYfc3HFm09CFs=;
        b=KT5VYxwF6XN/lLJF7sLvK5UgyrjCXvE8SuAkaCslReERIIUO4bXXxvgFciOrrHJPlR
         5e70I5R+84ebhwi0Gw3QeqrpPx1RLp8jP4CDfburcUuEp3DfZOtJJpR+NQSp1WFC+tBI
         FvId7ufLEs2Gb0n+0GdCLwg3e6NaeoLiIaLW0AREmbjyBJi74baMzHoIOTUsTiz+drAf
         brcQa+oKF/+5zotRTghKAbvJZWJ0Y7GPjyvMKA4wR+hTR9Bkyhh7RgIV+rVyJkLEeG62
         6/6Or3fkBaYLsU7nHi9d0lcdUu7dfJHXcy1gwTGDEQvZSHHxrZGkHfDhFhK+2Tg66K65
         T7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253135; x=1716857935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRUqZNfKo3bno7MhWC76z2IUcSm6kViYfc3HFm09CFs=;
        b=G7LlNzmOyRReM+s3B+z15/3Ym5dAwbT/Ji342SDqAT1/wt8lt5zN8eWmV10KapyEm6
         +ILZWWXFc8L4Y5DTzzsqs94IZJPootkHMbAUoURs1kh7PNUo3UNczC33TbC20LrcDokd
         9SDUg1eJef53JYbncNL3goOGTybTybPplv+b6Vtjj4nlYhaKIeWc/uPbcMqwAGFQyGIk
         Dond9VGeaULUAxfgbEuf6AlzCy/ItVTF9mc/M08fn4M6S/doAQlP+xhRHs7TbqZBYglH
         ehHSSHMHCorfTjq5+JxA8Trs2mFWqiMwk8z/DoqTd075Oh0h9eKX+u1xwlZf2GNZehBw
         +X9g==
X-Forwarded-Encrypted: i=1; AJvYcCVMkMpmZeVu51Ujgv1Kb2hb+5mCwY0RUTiNs0lxVEqan+dh4NU9pW08HKZWG9WrwV/CDoo4QVhgEgvFpPWVoCOSMFALUH1+
X-Gm-Message-State: AOJu0YwN8LpanQgM9Kpn3FVO7ar0q8nKXRgkJj+Y3HFRZFn+b8jWTGZC
	GxSSZCYPp1iLf4HlQ71umx2/FLpzoTzMBGqaVqiopYTAOsLNSRMuljldLPpwkRhuhCHGlK3sswd
	cfBDEpFeZTUw7IYGRCcIJGSfsK8k=
X-Google-Smtp-Source: AGHT+IHnlabDjJ1DFVkw+qtmmMcfyblLr89Pi/WLqMJyeXsa/ugGy2ckM7OZRacFrkhjVKNnYeBbG71B1gCpsCZINIY=
X-Received: by 2002:a17:907:3203:b0:a59:b8e2:a0c5 with SMTP id
 a640c23a62f3a-a5a2d66b509mr2614373866b.51.1716253134490; Mon, 20 May 2024
 17:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518025008.70689-1-kerneljasonxing@gmail.com>
 <CANn89iJqmp36tYxFgrTYqZ69EFc9c=eK69dhfPhriAwpk-fW-A@mail.gmail.com> <CAL+tcoB3ZXhYfGbdmR2ARit9VW9550wUXtaXroJ714Z6e0Hz=A@mail.gmail.com>
In-Reply-To: <CAL+tcoB3ZXhYfGbdmR2ARit9VW9550wUXtaXroJ714Z6e0Hz=A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 May 2024 08:58:17 +0800
Message-ID: <CAL+tcoCsTSW=cMReNEciFcJMCsFq9DxXoduOGFzmGTfrdR60Hw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 net-next] tcp: remove 64 KByte limit for initial
 tp->rcv_wnd value
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:36=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Tue, May 21, 2024 at 12:51=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Sat, May 18, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN r=
win
> > > to around 64KB") limited the initial value of tp->rcv_wnd to 65535, m=
ost
> > > CDN team would not benefit from this change because they cannot have =
a
> > > large window to receive a big packet, which will be slowed down espec=
ially
> > > in long RTT.
> > >
> > > According to RFC 7323, it says:
> > >   "The maximum receive window, and therefore the scale factor, is
> > >    determined by the maximum receive buffer space."
> >
> > This seems not relevant ?  wscale factor is not changed in this patch ?
> > tp->rcv_wnd is also not the maximum receive window.
>
> Thanks for your review.
>
> I can remove this part. I was trying to claim I do not break RFC.
>
> >
> > >
> > > So we can get rid of this 64k limitation and let the window be tunabl=
e if
> > > the user wants to do it within the control of buffer space. Then many
> > > companies, I believe, can have the same behaviour as old days.
> >
> > Not sure this has ever worked, see below.
> >
> > Also, the "many companies ..." mention has nothing to do in a changelog=
.
>
> Oh, I just copied/translated from my initial studies of this rcv_wnd
> by reading many papers something like this.
>
> I can also remove this sentence.
>
> >
> >
> > > Besides,
> > > there are many papers conducting various interesting experiments whic=
h
> > > have something to do with this window and show good outputs in some c=
ases,
> > > say, paper [1] in Yahoo! CDN.
> >
> > I think this changelog is trying hard to sell something, but in
> > reality TCP 3WHS nature
> > makes your claims wrong.
> >
> > Instead, you should clearly document that this problem can _not_ be
> > solved for both
> > active _and_ passive connections.
> >
> > In the first RTT, a client (active connection) can not send more than
> > 64KB, if TCP specs
> > are properly applied.
>
> Having a large rcv_wnd if the user can tweak this knob can help
> transfer data more rapidly. I'm not referring to the first RTT.

For the first RTT, it is surely limited to 64 KB at most as you said.

For the whole process, the change can accelerate the sending process
and save some RTTs.

How can I find this change? We had some servers upgraded to the latest
kernel and noticed the indicator from the user side showed worse
results than before. Because of this, I spent some time digging into
this part.

After applying this patch, the indicator shows normal/good results
like before. It is proven it works.

For the CDN team, they are very sensitive to the latency/time about
sending big data in the long RTT.

Thanks,
Jason

>
> >
> > >
> > > To avoid future confusion, current change doesn't affect the initial
> > > receive window on the wire in a SYN or SYN+ACK packet which are set w=
ithin
> > > 65535 bytes according to RFC 7323 also due to the limit in
> > > __tcp_transmit_skb():
> > >
> > >     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
> > >
> > > In one word, __tcp_transmit_skb() already ensures that constraint is
> > > respected, no matter how large tp->rcv_wnd is.
> > >
> > > Let me provide one example if with or without the patch:
> > > Before:
> > > client   --- SYN: rwindow=3D65535 ---> server
> > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > client   --- ACK: rwindow=3D65536 ---> server
> > > Note: for the last ACK, the calculation is 512 << 7.
> > >
> > > After:
> > > client   --- SYN: rwindow=3D65535 ---> server
> > > client   <--- SYN+ACK: rwindow=3D65535 ----  server
> > > client   --- ACK: rwindow=3D175232 ---> server
> > > Note: I use the following command to make it work:
> > > ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> > > For the last ACK, the calculation is 1369 << 7.
> > >
> > > We can pay attention to the last ACK in 3-way shakehand and notice th=
at
> > > with the patch applied the window can reach more than 64 KByte.
> >
> > You carefully avoided mentioning the asymmetry.
> > I do not think this is needed in the changelog, because this is adding
> > confusion.
>
> What kind of case I've met in production is only about whether we're
> capable of sending more data at the same time at the very beginning,
> so I care much more about the sending process right now.
>
> >
> > >
> > > [1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > v2
> > > Link: https://lore.kernel.org/all/20240517085031.18896-1-kerneljasonx=
ing@gmail.com/
> > > 1. revise the title and body messages (Neal)
> > > ---
> > >  net/ipv4/tcp_output.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 95caf8aaa8be..95618d0e78e4 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock =
*sk, int __space, __u32 mss,
> > >         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed=
_windows))
> > >                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
> > >         else
> > > -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> > > +               (*rcv_wnd) =3D space;
> >
> > This is probably breaking some  packetdrill tests, but your change
> > might [1] be good,
>
> I'll do some packetdrill tests and get back some information soon.
>
> > especially because it allows DRS behavior to be consistent for large
> > MTU (eg MTU 9000) and bigger tcp_rmem[1],
> > even without playing with initrwnd attribute.
> >
> > "ss -temoi " would display after connection setup  rcv_space:89600
> > instead of a capped value.
> >
> > [1] This is hard to say, DRS is full of surprises.
>
> To avoid confusion, I will remove this link and relevant statements.
>
> Here are my opinions in conclusion:
> 1) this change doesn't break the law, I mean, various RFCs.
> 2) this change allows us to have the same behaviour as 2018 in this case.
> 3) this change does some good things to certain cases, especially for
> the CDN team.
>
> I'll refine the changelog as far as I can, hoping it will not confuse
> the readers.
>
> Thanks,
> Jason

