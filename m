Return-Path: <netdev+bounces-98429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4BB8D1654
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44EC0B2324F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86761FE6;
	Tue, 28 May 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgTU6VOY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199A6EB64
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885287; cv=none; b=CU5Mk9ZzfM91T7jE+ZqS7K3+3IVM82zyrV/q3Of88aVzjxZl+E763O+K3RSZWxQjSXzgr+jLIZNivEy8N0rIg9iqWtbbwywzsxq4JZo9diasEI1vt8S+1PuXFfWZj6BqBni7EjTS5v4c6OKsbmspKRLCdbBrGFFDOPKlAtRgsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885287; c=relaxed/simple;
	bh=q9eEZSPGNmGn7FdG4B9iOtpUZAgzD7O2Yh+xU1WYfYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6IWKl5D+yVOJ0BW5s8WboILNj0HahibpmCb+7Qoea5oK/zkxKBlSitaI1K15nGePvFnyTOLvR3RXd1QU1ykOgqjFk+qcW/5jr9TL8/FkGK2vmq38u1U+R4tr4QXPxEaVmdJrkZhniL9/oZxP7RTTEHNmn9nESnBZCY5WOIGjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgTU6VOY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a626777f74eso64927666b.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716885284; x=1717490084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU7QsruyoFno25bdI/sc+T4+/uF8tCDflsgKNhyrsZU=;
        b=bgTU6VOYFZSnCVo/dEsQ1Ja4+4yVEXaIy65mya9PRkjy5WK8tu2K8B4Ery5TEaVt+c
         xUjlOX1oSC6FnxEvc0Vl+lxzz0umoZDTHVkZtZ3tNjPXZAHXMLin9/OhRgxczpdQQaAK
         aJEEaJ8QY27cOQuY9Z6ky6Xfs5LtZjyCx3wQRnr3Ly+ydz+7GtML7BaSGOBROrD1lcPP
         MiO7g8PXeePlHu2VjFF3238Ib8o6S6ktHWN+GIENH4TRW1rfiL5/rPnFJKaXFQNgqto/
         b/V/IQxowY8qhSRyvsts6i83bwPzJ98268LKFwp/k+2GEExvVfH4z3RnwXTs0LWPeKc6
         MP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885284; x=1717490084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU7QsruyoFno25bdI/sc+T4+/uF8tCDflsgKNhyrsZU=;
        b=suKZ9aVEMQuNRTOfIMVlqMakIiTnSC87ZppaBpvl1elDEBh8dm1w7ZB3XyZeltblDw
         qmrDMvDe5sSX9N0Grk10O72+p3SmW4Bv1WgUCDQgD9Sl14EZ1VYhvvkIy4mEpFcUd1Yx
         UDOOYW3JVZ7lfgBRCPPnmuZ24StuAsl2dEENp7m4OCTldSYEvm0XdSJdLRtKjbqQt56x
         P142pP0gz/+5gK+WORQvLki16hLQaNufSepM2QfOufObonnylfbDX+rFEGG6rcjiVqsT
         XQ4e1+Pfky78yEWivTo1k3lrZHWW7p4WBOaSmyD1EQGMj85CHsM2HleeBbAco3gYoH1r
         wCGA==
X-Forwarded-Encrypted: i=1; AJvYcCWsSMeov6qOME6XWfvrC51zzdKCYDKvCXzFAw5++1t6UbBQ8NuaL/bB5d5ycCOzsMdypAndUkj3Ca23lpe1NMiRG42htvQz
X-Gm-Message-State: AOJu0YynXwfuWtPfCLi9hlAk78947BoEWE6/7YLZ+XthEhicXU5T9MLG
	37w7wNAwob7C4vAl0BTVZtBFbouY0uUesuM1/914YqgJocEEh8okhFViPGLv1D9qTToMVG9i7gW
	GFxAO5a3upipaSGDqa0/lUp18deBOMsRR
X-Google-Smtp-Source: AGHT+IEsPLrFhJLYN39qQIpJfo74Gm82+ZbvGRc1RnFp+C1FM1g+NlF6QJKgtS3So0abOF7FV/Pc8tJCMn1GDN1fGE0=
X-Received: by 2002:a17:906:3095:b0:a59:d527:4339 with SMTP id
 a640c23a62f3a-a62635a3d8bmr1096978866b.0.1716885283649; Tue, 28 May 2024
 01:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528021149.6186-1-kerneljasonxing@gmail.com>
 <CANn89iJQWj75y+QpLGQKZ6jBgSgpi0ZtPf4830O8S0Ld2PpqEg@mail.gmail.com>
 <CAL+tcoCSJrZPvNCW28UWb4HoB905EJpDzovst6oQu-f0JKdhxA@mail.gmail.com> <CANn89i+zbXNOJtxJjMDVKEFt2LnjSW9xGG71bMBRc_YimuqKLA@mail.gmail.com>
In-Reply-To: <CANn89i+zbXNOJtxJjMDVKEFt2LnjSW9xGG71bMBRc_YimuqKLA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 May 2024 16:34:06 +0800
Message-ID: <CAL+tcoAO2aqoGLV7ixL=M-Fi7GU6juD-RQhtn7YASoe5_tjxZw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yongming Liu <yomiliu@tencent.com>, 
	Wangzi Yong <curuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, May 28, 2024 at 8:48=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Tue, May 28, 2024 at 1:13=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, May 28, 2024 at 4:12=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > CLOSE-WAIT is a relatively special state which "represents waiting =
for
> > > > a connection termination request from the local user" (RFC 793). So=
me
> > > > issues may happen because of unexpected/too many CLOSE-WAIT sockets=
,
> > > > like user application mistakenly handling close() syscall.
> > > >
> > > > We want to trace this total number of CLOSE-WAIT sockets fastly and
> > > > frequently instead of resorting to displaying them altogether by us=
ing:
> > > >
> > > >   netstat -anlp | grep CLOSE_WAIT
> > >
> > > This is horribly expensive.
> >
> > Yes.
> >
> > > Why asking af_unix and program names ?
> > > You want to count some TCP sockets in a given state, right ?
> > > iproute2 interface (inet_diag) can do the filtering in the kernel,
> > > saving a lot of cycles.
> > >
> > > ss -t state close-wait
> >
> > Indeed, it is much better than netstat but not that good/fast enough
> > if we've already generated a lot of sockets. This command is suitable
> > for debug use, but not for frequent sampling, say, every 10 seconds.
> > More than this, RFC 1213 defines CurrEstab which should also include
> > close-wait sockets, but we don't have this one.
>
> "we don't have this one."
> You mean we do not have CurrEstab ?
> That might be user space decision to not display it from nstat
> command, in useless_number()
> (Not sure why. If someone thought it was useless, then CLOSE_WAIT
> count is even more useless...)

It has nothing to do with user applications.

Let me give one example, ss -s can show the value of 'estab' which is
derived from /proc/net/snmp file.

What the corresponding CurrEstab implemented in the kernel is only
counting established sockets not including close-wait sockets in
tcp_set_state().

The reason why it does not count close-wait sockets like RFC says is unknow=
n.

>
> > I have no intention to
> > change the CurrEstab in Linux because it has been used for a really
> > long time. So I chose to introduce a new counter in linux mib
> > definitions.
> >
> > >
> > > >
> > > > or something like this, which does harm to the performance especial=
ly in
> > > > heavy load. That's the reason why I chose to introduce this new MIB=
 counter
> > > > like CurrEstab does. It do help us diagnose/find issues in producti=
on.
> > > >
> > > > Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CUR=
RESTAB
> > > > should include both ESTABLISHED and CLOSE-WAIT sockets in theory:
> > > >
> > > >   "tcpCurrEstab OBJECT-TYPE
> > > >    ...
> > > >    The number of TCP connections for which the current state
> > > >    is either ESTABLISHED or CLOSE- WAIT."
> > > >
> > > > Apparently, at least since 2005, we don't count CLOSE-WAIT sockets.=
 I think
> > > > there is a need to count it separately to avoid polluting the exist=
ing
> > > > TCP_MIB_CURRESTAB counter.
> > > >
> > > > After this patch, we can see the counter by running 'cat /proc/net/=
netstat'
> > > > or 'nstat -s | grep CloseWait'
> > >
> > > I find this counter quite not interesting.
> > > After a few days of uptime, let say it is 52904523
> > > What can you make of this value exactly ?
> > > How do you make any correlation ?
> >
> > There are two ways of implementing this counter:
> > 1) like the counters in 'linux mib definitions', we have to 'diff' the
> > counter then we can know how many close-wait sockets generated in a
> > certain period.
>
> And what do you make of this raw information ?
>
> if it is 10000 or 20000 in a 10-second period, what conclusion do you get=
 ?

Some buggy/stupid user applications cannot handle taking care of
finishing a socket (by using close()), which is a very classic and
common problem in production. If it happens, many weird things could
happen.

If we cannot reproduce the issue easily, we have to trace the monitor
history that collects the close-wait sockets in history.

With this counter implemented, we can record/observe the normal
changes of this counter all the time. It can help us:
1) We are able to know in advance if the counter changes drastically.
2) If some users report some issues happening, we will particularly
pay more attention to it.

>
> Receiving FIN packets is a fact of life, I see no reason to worry.
>
> > 2) like what CurrEstab does, then we have to introduce a new helper
> > (for example, NET_DEC_STATS) to decrement the counter if the state of
> > the close-wait socket changes in tcp_set_state().
> >
> > After thinking more about your question, the latter is better because
> > it can easily reflect the current situation, right? What do you think?
>
> I think you are sending not tested patches.

No.

Honestly, what I've done in our private kernel is different from this patch=
:
I added a new counter in 'tcp mib definitions' (see diff patch [1]).
You know, it is not good to submit such a patch to the kernel
community because 'tcp mib definitions' enjoys a long history and not
touched more than 10 years. If I do so, I can imagine you might
question/challenge me. I can picture it. :(

Then I decided to re-implement it in 'linux mib definitions'. This
file is touched in these years.

[1]:
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index adf5fd78dd50..27beab1002ce 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -144,6 +144,7 @@ enum
  TCP_MIB_INERRS, /* InErrs */
  TCP_MIB_OUTRSTS, /* OutRsts */
  TCP_MIB_CSUMERRORS, /* InCsumErrors */
+ TCP_MIB_CURRCLOSEWAIT, /* CurrCloseWait */
  __TCP_MIB_MAX
 };

diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 6c4664c681ca..5d2a175a6d35 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -157,6 +157,7 @@ static const struct snmp_mib snmp4_tcp_list[] =3D {
  SNMP_MIB_ITEM("InErrs", TCP_MIB_INERRS),
  SNMP_MIB_ITEM("OutRsts", TCP_MIB_OUTRSTS),
  SNMP_MIB_ITEM("InCsumErrors", TCP_MIB_CSUMERRORS),
+ SNMP_MIB_ITEM("CurrCloseWait", TCP_MIB_CURRCLOSEWAIT),
  SNMP_MIB_SENTINEL
 };

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 681b54e1f3a6..f1bbbd477cda 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2659,6 +2659,10 @@ void tcp_set_state(struct sock *sk, int state)
  default:
  if (oldstate =3D=3D TCP_ESTABLISHED)
  TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+ if (state =3D=3D TCP_CLOSE_WAIT)
+ TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRCLOSEWAIT);
+ if (oldstate =3D=3D TCP_CLOSE_WAIT)
+ TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRCLOSEWAIT);
  }

  /* Change state AFTER socket is unhashed to avoid closed
--
2.37.3

>
> I suggest you use your patches first, and send tests so that we can all s=
ee
> the intent, how this is supposed to work in the first place.

This patch is not proposed out of thin air.

Normally, we have two kinds of issue/bug reports:
1) we can easily reproduce, so the issue can be easily diagnosed.
2) It happens in history, say, last night, which cannot be traced
easily. We have to implement a monitor or an agent to know what
happened last night. What I'm doing is like this.

A few years ago, I worked at another company and cooperated with some
guys in Google. We all find it is hard to get to the root cause of
this kind of issue (like spike) as above, so the only thing we can do
is to trace/record more useful information which helps us narrow down
the issue. I'm just saying. It's not effortless to deal with all kinds
of possible issues daily.

And finishing the work of counting close-wait sockets according to RFC
is one of reasons but not that important.

Thanks for your patience and review and suggestions :)

Thanks,
Jason

