Return-Path: <netdev+bounces-119796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5AB957012
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA5EB299EF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F7156C78;
	Mon, 19 Aug 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPBgx2Qm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094C13B5AF
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083924; cv=none; b=WTY27f57EywYw1nhRTl93+ouT7xfE62Nx/QKDnmGZiIULGLh3gWNXm6lPsxRyxV1Qz24IuUfIqfqBZNxA/twEjGg2gfFJyy6P7h1PfYQWQlj7vG5gJhN/iyVvZfHeH5Wyj7AJSMts8HqrC1tOpnFEeNbSQ4JIc4f5rADuQSWht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083924; c=relaxed/simple;
	bh=Lt6xZPtzAOc9rRRWGBPozLAijSECedPuHpKXpbE1WIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8RKvnl+q5MnxdM+56bsnQWEWThvMIws2VE2580Meb2EOrlu13W2UXiXz9k2AEVdX24iPaPZ5Dx/p+rAU9ODnLoziFy3KXFlv+ZwH5aad4SssMQRFhlBNrv2smGn7EC9HDPGDSfvfEn9Hpzx89UQNGouc8RhU9Cg98Ac1VSjHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPBgx2Qm; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d3c8bc608so7723905ab.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083922; x=1724688722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt6xZPtzAOc9rRRWGBPozLAijSECedPuHpKXpbE1WIU=;
        b=dPBgx2Qmc6p3qY0LduDpHEIKfJHGFbop3PeSeN6mcTov7L6796ZVOdOVxH0EqXjCHC
         2moR/LytDTdv6jMooiW3Jub2GbFRTa5vUmQNsakqdJbxJMQszDkA7I2Av5TB3+l92y4/
         CQgCUc56LboTQXHVRCCmCLmvZ5/6HXTA4Qm4x4ErnVDObP3INSkNEL0bz+XXRYOwFUqY
         Mtfj30Ej8m1s6JpNxQyyiNXjLzFvEaYBrlJyc37lB2D1eonCaZyMhZ+u357xPj0y/ydz
         c+sJzNJGQTtA1fVKWgd4iab9STnQUkc8AIYG017b6JkbwgPC1k8CN/AWti3GYUhE8Ql+
         BV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083922; x=1724688722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt6xZPtzAOc9rRRWGBPozLAijSECedPuHpKXpbE1WIU=;
        b=fkfRZdJfhxZkBLflpWD7j/I96DMYmfHWxkZk/WNSnZq7dpeF2WXTNjvHr00Sx+bswg
         kPcqYClceU9cFT5qTIOsqs6p665z9ZbE2sSA56fhNLu9mavfe3z0ETW2D1R/ME98Tkrt
         oKFIoSyo7yOS2La9d/qBuZYUtLv3h88L5cISJ0m8K/2B+vcW7RICnAu30usKT20tPHl9
         BY7wJGv2QEq+tJhEMNno7f/gC8N5Ge1KYCIV8uCy2p0vAaVHe3kaDJg9YvSa9GWrRKBY
         95ocr7Gz8cVOxCxzXmTgz3cN2fEKXcb3pd/sIJu3GO+iy0etV+EXZqXoLWv7/1sEBpRN
         g+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUR+2/FV9sImX2FEijY6JjGv8GCsIo98PgRLHfsbOqhkgkDXu3zEzzXsCdwVRhjw+4KMxPD54ucrb2cx/yUD0dRuL7cKmUS
X-Gm-Message-State: AOJu0Yx4ZMfZ7nFsPvnFPZNKjeGl//Z3ul0VhItMec2QAm2vz6knv0Ib
	FztpE5fFVaTCUvDtt76Xbm7H9tO5GxmwBwx9ZmjCdCWeLIPstL/VVZr6OidLtjmFNVLIP1H7Pcu
	qaojQdjXyiJMUuuLMbt1xh5C8VJM=
X-Google-Smtp-Source: AGHT+IGHEXI7UPLDVfUrb8vNr79zSKBAx01JU5hwEOwznQRqcleWeoLoIbjyicbO3aMNXxtXgJ+4huwb3sMpCd+fw28=
X-Received: by 2002:a05:6e02:1a85:b0:39d:35f2:6ed7 with SMTP id
 e9e14a558f8ab-39d35f27038mr79896405ab.27.1724083921669; Mon, 19 Aug 2024
 09:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816153204.93787-1-kerneljasonxing@gmail.com> <CANn89iJZ8RwFX-iy-2HkE=xD8gnsJ26BO5j=o0460yUt7HiYcA@mail.gmail.com>
In-Reply-To: <CANn89iJZ8RwFX-iy-2HkE=xD8gnsJ26BO5j=o0460yUt7HiYcA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 00:11:25 +0800
Message-ID: <CAL+tcoACq7d6ADnDr-Fd_QyBQ=kbC4cjqs1eqLwrcFKHf4ZmHg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: change source port selection at bind() time
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:45=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Aug 16, 2024 at 5:33=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This is a follow-up patch to an eariler commit 207184853dbd ("tcp/dccp:
> > change source port selection at connect() time").
> >
> > This patch extends the use of IP_LOCAL_PORT_RANGE option, so that we
> > don't need to iterate every two ports which means only favouring odd
> > number like the old days before 2016, which can be good for some
> > users who want to keep in consistency with IP_LOCAL_PORT_RANGE in
> > connect().
>
> Except that bind() with a port reservation is not as common as a connect(=
).
> This is highly discouraged.
>
> See IP_BIND_ADDRESS_NO_PORT
>
> Can you provide a real use case ?
>
> I really feel like you are trying to push patches 'just because you can'.=
..

You apparently got me wrong and hurt my feelings :/

Since you asked me about this one, I'm going to tell you the whole story.

A few years ago, one of my colleagues reached out to you and
complained about the issue of the new port selection algorithm
(odd/even port selection) to you. But a few years later, the community
finally implemented/extended such IP_LOCAL_PORT_RANGE option to
support finding a suitable port one by one. I'm not sure if you
remembered.

Nearly every month I get issue reports about why the latest kernel
applies a new algorithm because of the high cpu-load increasing so
much suddenly, then I will let them use the older one which I use a
sysctl knob to control internally.

If you pay more attention in these years, you've received more than
one patch trying to use the older algorithm provided for users, even
though they are not accepted. You may ignore the fact. For me, I just
want to provide a way/patch to use the older algorithm for connect()
and bind(), which can be accepted by the community relatively easily.
That's all. I don't believe we are the only special one! So I want to
change something!

Like that 'self-connection' issue, we are also not the only one, so I
exert/push myself to solve the issue thoroughly.

To be honest, whether you accept the patch, I cannot control it, but I
will try my best to do some useful reports and provide real use cases
which are derived from our production.

That's not bad, right?

