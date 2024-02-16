Return-Path: <netdev+bounces-72353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0033C857AC2
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6427CB21022
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588854F90;
	Fri, 16 Feb 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRVtfj0m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528654F8F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080966; cv=none; b=U2czEYPL7tKJg8IvCLz/hkigwVMbqE83mLj3UhHgDC5T+ENM5E7DAH1OwfWxILvGBW1jk7bhY7SPC+A2gLCFl6tCpHbcDpY69zVWg1/ytOjRiKSE8nDBh/1hfGdaHlVkaHM58tOmdzsAWLybbm6IdAX1PZWKwAf6bxtjTycGdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080966; c=relaxed/simple;
	bh=Xfey/PP91gDqZcdL6BMLSmHY+MxzQMJGvrnXCmsw/WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFzv64rPPPi2n3mHbH+JasxV3MG4Iv49TpFjcUyw6IXn9TgWDsW4tggK1SvZlIA3STnJeZDm9hR10UsdDUlLHWWI49hpMxKr3FPtDfWwM5yPK5gAPlWJthrxa9qzjQSR/tJ7wcc7R78hpmOKujzYLcFMQHKRzZbG8p57vDJgzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRVtfj0m; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so5894a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708080961; x=1708685761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX2M6t+HpO+1iW7i0PqIiahh3l0yTGcSe9sM2hZ/jGk=;
        b=lRVtfj0mrXyqCaFUa/DPLLJe2EvNxUVlKtH83ExTjGINSiiArbSP5a2EgrcqpWKNbN
         ebgTgn7CgudqJiInA9hVoS0M3fZDI3euyqeKC8jIZD7FLmD9g0gb7egxiQRwXtIqeNKj
         CJ7b22kH0IHWHsa8KaY+nrjaD/Wg1NuqXrnBV4jXGfqxsQSYx+Hwm7W5FpGReKt7+NXY
         hs6fR55kY6W4aFdBDhnMvD0IS/7qWqp0Zeo72+o5ImBZ+kEESyez2OigiFtw/HRrlkUV
         nLzkZRO29ys4KhObiKEXsWuzbWorEBjObrvQNLJVWwDFBHckVe9rkUXRXPUA0kRWuNcX
         ycdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080961; x=1708685761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX2M6t+HpO+1iW7i0PqIiahh3l0yTGcSe9sM2hZ/jGk=;
        b=K2SfBW2/fh43yowzCmXsgqebw9ln4Ofw/HXsrL6xN9hEJ+KF3jPUm2cSI1DngicDeW
         xAxhXba22UBstH08N3VxWstbg/qHwC9ki+zokAOejSTWAkx8oAZyuYT0IPm2WHauJuBa
         nMFaDdMxSHGFx6PYRVfZZahSE7npqjh0cR4ZqXgi2OoI5CKTvZpJxTzJOd3MyWzckIXt
         3PH6nU4o0qAqphwRYuVncjzi9L0P0oIBFwbHdbnShjTrPOwgVvt5GbK+3a4ccDTNOc8n
         sHMQhNkwTYItY89pBWCatZwoXc6AdHKX6AC7H6KJlONRxqnoXIljH3oP/cJz9H27Qsa/
         26iA==
X-Forwarded-Encrypted: i=1; AJvYcCXragLRNqkw8wLwW/srMnOaCHUylSjMILM1lMnsSQAsQ2iGBZkKLvDmcNssrEeE9oOvy//vU9cfs8sX3jk8hYESRyV6i2ta
X-Gm-Message-State: AOJu0YzPFfHmv7mqTkmcXMXTNhAIqnMhAb5A/vtzXnXZev/LA4zs9Owx
	lYh54p5RKFe5/9eJwBAmfhF+PeK7nyXTX0noQJDUTWDid9xv7mTtdzY2eGzNFQIScAOsfI+5TB2
	ggH7LpRkUP8hzTFYm+2q9gjsJKvildBisH7tu
X-Google-Smtp-Source: AGHT+IGlX1QR+LHgM3dgNRGRSkvm9KLpPPg++QJMcF0mCAyVVyKKfI28CC4iVOan2649soOqYcRz1ihtr7hV1nJKQCg=
X-Received: by 2002:a50:d546:0:b0:562:deb:df00 with SMTP id
 f6-20020a50d546000000b005620debdf00mr148059edj.4.1708080960777; Fri, 16 Feb
 2024 02:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
 <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
 <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com> <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
 <CANn89iKXOZdT7_ww_Jytm4wMoXAe0=pqX+M_iVpNGaHqe_9o4Q@mail.gmail.com>
 <89f263be-3403-8404-69ed-313539d59669@redhat.com> <9cb12376da3f6cd316320b29f294cc84eaba6cfa.camel@redhat.com>
 <CANn89i+C_mQmTFsqKb3geRADET2ELWeZ=0QHdvuq+v+PKtW0AQ@mail.gmail.com> <6a9f5dec-eb0c-51ef-0911-7345f50e08f0@redhat.com>
In-Reply-To: <6a9f5dec-eb0c-51ef-0911-7345f50e08f0@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 11:55:47 +0100
Message-ID: <CANn89iJHDdF=bbtbs_WkmPG7Km1YNO9miuGW6SGOm-CtJQzM5w@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: Jon Maloy <jmaloy@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, passt-dev@passt.top, 
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:13=E2=80=AFAM Jon Maloy <jmaloy@redhat.com> wrot=
e:

>
> There is also the following alternative:
>
> if (flags & MSG_PEEK)
>        sk_peek_offset_fwd(sk, used);
> else if (flags & MSG_TRUNC)
>        sk_peek_offset_bwd(sk, used);
>
> This is the way we use it, and probably the typical usage.
> It would force a user to drain the receive queue with MSG_TRUNC whenever =
he is using
> MSG_PEEK_OFF, but I don't really see that as a limitation.
>
> Anyway, if Paolo's suggestion solves the problem this shouldn't be necess=
ary.

I think the suggestion to move sk_peek_off came from my first message
on this thread ;)
 "We need to move sk_peek_off in a better location before we accept this pa=
tch."

Anyway, a complete reorg of 'struct sock' was overdue, I am working on it.

