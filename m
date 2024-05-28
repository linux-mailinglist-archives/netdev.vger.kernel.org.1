Return-Path: <netdev+bounces-98432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22928D16AC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD851C21C2D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20638DE9;
	Tue, 28 May 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+MPSFnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEE17E8FC
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886374; cv=none; b=EbhgjimsWc9wy+39Zxletv8t9cc1Zo1GMJWAwhu9gioXQWjJLcm/zO1tfo/FyXLAgBZTjWfC6cUrVdTzVmwQfjCzRUd137UZ2iReds2O4gg32jI6/2hEciI8NDVNU+dPdx9DSi13CYZH6LCg7zpmf65fvuocxLa04reV/6ev2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886374; c=relaxed/simple;
	bh=KTVHSWvkSSxxBhxBNL2Ok/MrQh6s9bnk1XzVAUt1F54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuytqRhOVkKt8V0SQ81YSQ/aGmTqfK8nku2sv3IfoW+mjLD+8Ia2hlQVZMmu4moe35wtIEJzIwQx21E1/upolekngj8+ybOTj87rS63kfKtJ8c+eFrgpaZuUaDqRRP7VMmhgdq45Eds5PZsjiv7BJnDx9DXCAzs0sd6gH5pBwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+MPSFnj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354f51ac110so588072f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716886371; x=1717491171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJBZR2cnadCMarXmBpDKmr3ZQjAuj8713bjCzolmjDk=;
        b=l+MPSFnj+kI0mdAJHHmcFiIfE0BYmgnMIf8pvQSQ7CKVtiDU3XfF7d5cKlJv4d9b8n
         iWaunFELSKLdyXJAT8klqrd/RJS7lxT4nf2s4b1WdtlV04bozI1mar/hvfPEEs0e218c
         ARMEx3W0/H968kpDkAhgmFArYUdQ9O5Ykrh0Yax99Y7GkZeHtQ2Y1woO0Mh/w02Cpul2
         FGleVV8MDMZKKmU0EAmWz3ThN6UeF9EXgi6XphKaLbrjig4cmbdjd2OVQedOXo758JUT
         pUhZlBW13PhXOrfU1Vp5sGIujpF0fs8LtxCRaeYnkCgxJAiTTdQD2oR4LlWUcK4V3qr4
         aByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716886371; x=1717491171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJBZR2cnadCMarXmBpDKmr3ZQjAuj8713bjCzolmjDk=;
        b=qj6oRaqsDLREFcwGTlv5Y3QTP6MSjcBgzLD185So0fSkolJeobUo9q8XiHLTTuk+Ol
         NGiX+zR6upVTguRWWvLlPzUKoO7TVAHU8R6LTnZEynfsMJkD+Fw8SHTKN4n7TWMRiSQN
         w0qXIykA3+Qu4X1Ia+/8Zc7IS75h0q4ANdvPK/Co2Jv7RuJxOZFK2upAlnEY4RYcoX7n
         BUkzHX0TJRxasv8/F6ev2YYTdBOdKJeyPwgWYrdV3Rgsj6R+pm8LbuCk3AjeUK1c1Pt0
         fFIlQhiZXSmga15Ns9t9yD86Nl80Bxw7RKxEoqHB6ECwnnSTtoZBDRAZZ77NE82okiaH
         dLiw==
X-Forwarded-Encrypted: i=1; AJvYcCXquqfFVhe3/md8UArqBq4DUkWuYZVJBBS6Oi/yyOMRsppoqVGo8rEeMCPhq/rxy+MoIxUzsm76lPcXv4xhbiHiF5eO9G63
X-Gm-Message-State: AOJu0Yz/JTBt2/5JHlvawBxlZwb7yZT3hsznrnLFi8r15TGoiQqp8tot
	6CHnBJtS2Q5pRujwpKIBRmrBWlfmvpTEnz1FSXGSPDf9xldn9DBt2xA0RlANB09pmxJZOlWdk8m
	H4sSC9ezfA2s1ePwPvc0uEqL0V9U=
X-Google-Smtp-Source: AGHT+IH8QgME52sbZDG1pGXAOdkWCeI/tt7+VP6foeNdeCvztPgy32CIxCxn5SKqaQ13J9ZWRwFC8hDtnTwQvuwXSiI=
X-Received: by 2002:a05:6000:ec2:b0:354:f447:9f27 with SMTP id
 ffacd0b85a97d-3552fe02923mr9004677f8f.55.1716886371113; Tue, 28 May 2024
 01:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528021149.6186-1-kerneljasonxing@gmail.com>
 <CANn89iJQWj75y+QpLGQKZ6jBgSgpi0ZtPf4830O8S0Ld2PpqEg@mail.gmail.com>
 <CAL+tcoCSJrZPvNCW28UWb4HoB905EJpDzovst6oQu-f0JKdhxA@mail.gmail.com>
 <CANn89i+zbXNOJtxJjMDVKEFt2LnjSW9xGG71bMBRc_YimuqKLA@mail.gmail.com> <CAL+tcoAO2aqoGLV7ixL=M-Fi7GU6juD-RQhtn7YASoe5_tjxZw@mail.gmail.com>
In-Reply-To: <CAL+tcoAO2aqoGLV7ixL=M-Fi7GU6juD-RQhtn7YASoe5_tjxZw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 May 2024 16:52:14 +0800
Message-ID: <CAL+tcoCz31PPOqjOvfh0OwkJvM_CHo4vNteAWhNZNfrcs57uug@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yongming Liu <yomiliu@tencent.com>, 
	Wangzi Yong <curuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 4:34=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, May 28, 2024 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, May 28, 2024 at 8:48=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Eric,
> > >
> > > On Tue, May 28, 2024 at 1:13=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Tue, May 28, 2024 at 4:12=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > CLOSE-WAIT is a relatively special state which "represents waitin=
g for
> > > > > a connection termination request from the local user" (RFC 793). =
Some
> > > > > issues may happen because of unexpected/too many CLOSE-WAIT socke=
ts,
> > > > > like user application mistakenly handling close() syscall.
> > > > >
> > > > > We want to trace this total number of CLOSE-WAIT sockets fastly a=
nd
> > > > > frequently instead of resorting to displaying them altogether by =
using:
> > > > >
> > > > >   netstat -anlp | grep CLOSE_WAIT
> > > >
> > > > This is horribly expensive.
> > >
> > > Yes.
> > >
> > > > Why asking af_unix and program names ?
> > > > You want to count some TCP sockets in a given state, right ?
> > > > iproute2 interface (inet_diag) can do the filtering in the kernel,
> > > > saving a lot of cycles.
> > > >
> > > > ss -t state close-wait
> > >
> > > Indeed, it is much better than netstat but not that good/fast enough
> > > if we've already generated a lot of sockets. This command is suitable
> > > for debug use, but not for frequent sampling, say, every 10 seconds.
> > > More than this, RFC 1213 defines CurrEstab which should also include
> > > close-wait sockets, but we don't have this one.
> >
> > "we don't have this one."
> > You mean we do not have CurrEstab ?
> > That might be user space decision to not display it from nstat
> > command, in useless_number()
> > (Not sure why. If someone thought it was useless, then CLOSE_WAIT
> > count is even more useless...)
>
> It has nothing to do with user applications.
>
> Let me give one example, ss -s can show the value of 'estab' which is
> derived from /proc/net/snmp file.

Speaking of the CurrEstab, for many newbies, they may ask what the use
of this counter is? For me, I would like to share an interesting issue
report I ever handled.

One day we had a moment when most CPUs were burned (cpu% is around
80%) and most applications were stuck all of sudden, but this
phenomenon disappeared very soon. After we deployed an agent
collecting the snmp counters, we noticed that there was one
application mistakenly launching a great number of connections
concurrently. It's a bug in that application.

Even the CurrEstab is useful, let alone the counter for close-wait.

Thanks,
Jason

