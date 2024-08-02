Return-Path: <netdev+bounces-115279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7F945B79
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495AFB20CEE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A70F15B134;
	Fri,  2 Aug 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao1lUH0+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2E4C62A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592228; cv=none; b=EROcrI/EoJN8pPUi+QAH4sinrJMiXoHa6rZYiyf4aoVhhtHslgRcq1Ys4w/DQxoFp6IEjfNgiZvycZwskUdwTLRWcMM13MkpvegvSI8oe7cu6tOgdn3QFaNhGWghhsyiJwHRW9TGkjmVVMAxbwL9XzuVaQGcWtfa+yl/QOGmV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592228; c=relaxed/simple;
	bh=uL5kSe3b5OqWRVcrAlse4ukPptfV8owEC57405F0sUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iON66Vr4dgIGjNPrV5gs2yWWPRv9CVQfYavTJR73I4QNxXPNQ5B7njuvFnwqvOZXdawFkL7WCnEHpILo5y/Hu6bknN97qqdbuR8Y/ZPa8/tuqQzc0VOrOLxPbEiIonCqtxuOT4+fIsUsyPkBxJvsLPzA0NtobmWFXbPviLutr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao1lUH0+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so426330a12.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722592224; x=1723197024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL5kSe3b5OqWRVcrAlse4ukPptfV8owEC57405F0sUU=;
        b=Ao1lUH0+l6sc6JYpGYmX/W1lbSoPWKkHWMB40531G3r0xo6n6uaAyI81RpWBaYXmr1
         i5Q30RvTgcUjKEjXtXyMHlE2gXe3eP1E46M/MTp8nkSOPcZiD2BdxXL59Sd14SipUvLs
         /bkAoI6mkb2g3T2UQD4ysIn9XfuG5qT+P5kewRQXH33JGlEa4eEmobc5++zDpJUqM+I5
         3Ml5HId4ufYYmfPjrIJOnrzCckrG0FzKswuJlgPUChEUcc14ISuXo8o/ylS0kBzvFUXH
         cnnlOGqYifmwlud68Zjxe/IiS8wAojJL0qj9v7tX/MObcKgCyQ3qthXEWLMBQCb2xeX7
         Z4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722592224; x=1723197024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL5kSe3b5OqWRVcrAlse4ukPptfV8owEC57405F0sUU=;
        b=c7uFqqSjAeoyGmRIplcjPMLfg+DRGTBC3kOOD5VvNW4fLRf6RS+yh0y0ByXgwiyTqt
         xOGDVDgGTPEFWSVwlLkfoplN39vQRIKjXBewWsylIUOHinKC21PfHDLiFHPXmn1vvV5z
         iTx4fAGJma/OLW5x300JATeQeuIwnGI1inqZi0YpPi85kP4hMAYlYmfUS+snFSgeppex
         ezSrcy3WrHWVYw/OwGKWFxM98rj0JzxZ4Zgr8gsr2ctLF8p3m/w87eDzVPSEDK4z/XKa
         sIHjq4t05mdKvwm0d4/776zZ34bBTGxhcVnizxj9YZMn3h/srCHd++pGXMZJxa48ei66
         CF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW40GfBp76L0XS98B+pSVmDSnVvuNYFCn1Laj/14ZG+Q7j4ro3WFafH4a2zzQCzVTnGG5OWZqn72u4eizDrFqCxUBevW4hw
X-Gm-Message-State: AOJu0YxlIwW8ZkoHqOFvPdmZ/PuZZSlFAnwY9cEorXHfmRTkDIzFxA3/
	d6cnPmzI843KTpdpc6cc8s7JkbOCN6rYXQ6MoDu2BtJC3dmQAaVNhGtvA6dpkywQVwkCbGWgwc+
	PejlKiDw14uN2ge9eL5HO4IB/J28=
X-Google-Smtp-Source: AGHT+IH0z5Oscoiy8rtOEhr3kjh6lFycGTBWvj11En3nSeCCswFMMS0KkHkO+79DBRR25bfu5husS8DY3y4RwGSh48M=
X-Received: by 2002:aa7:c053:0:b0:5a1:369b:bb61 with SMTP id
 4fb4d7f45d1cf-5b7f59e0918mr1711921a12.36.1722592224014; Fri, 02 Aug 2024
 02:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
 <20240801145444.22988-5-kerneljasonxing@gmail.com> <CANn89iLjYcVa0MZHBrWvz2qYF2y5aV23uBkt3fnpNTQEo=nvEA@mail.gmail.com>
In-Reply-To: <CANn89iLjYcVa0MZHBrWvz2qYF2y5aV23uBkt3fnpNTQEo=nvEA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 2 Aug 2024 17:49:46 +0800
Message-ID: <CAL+tcoCvMVJLU+1SznRmA8uKtVO=_FH0S9EavU7Y-ffBYu1NjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] tcp: rstreason: introduce
 SK_RST_REASON_TCP_STATE for active reset
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Fri, Aug 2, 2024 at 5:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Aug 1, 2024 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introducing a new type TCP_STATE to handle some reset conditions
> > appearing in RFC 793 due to its socket state. Actually, we can look
> > into RFC 9293 which has no discrepancy about this part.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> I really think this SK_RST_REASON_TCP_STATE is weak.
>
> 'Please see RFC 9293' does not help, this RFC has more than 5000 lines in=
 it :/

Yes, there are various reasons and conditions written in RFC 9293
nearly all over the place. I'm unable to conclude and get an union
name. Sorry about that. If I figure out a better name in the future,
I'll let you know.

>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for all your help.

Thanks,
Jason

