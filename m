Return-Path: <netdev+bounces-98407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6618D14AE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D664C1F241E1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF56EB5C;
	Tue, 28 May 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWq7goex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF21BDD3
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878940; cv=none; b=BxgCjLMPXXkdJJMFEczTypsFHrwOUbOm3WM6/El51FDzHponoExAf5clCL4PfKzgEHbLkMEBjlpemBCQC++Fqb6T1HSkodWg9lBkPtU4lYOl7my+902/HWiSxUtQ8ShI+fzpdmLVgXTowUlER+WclFCV8YMgImYofd98LHM6Sa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878940; c=relaxed/simple;
	bh=Nsp68rVAWZLMrCblRzN41IGaqc1qqdovnQ05kfrVD8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K37W04JbkQq8ZG7FOVw9QE0hsY4sexrgn0PoJziECDNnKBaThAGhRwxAtaDa391eHrrHHXnodR/9UhpV0vZJ2U+stR+FbqSn9ck3C/P9YzfDuu/x8Fd9fQ5e3wAbDWmQkatpiLgaVoSb2fDuRjNQSGSLn+dXZn0jIB9UMHw9sYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWq7goex; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-529682e013dso507862e87.3
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716878936; x=1717483736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2y3qumDVDkg8QQb5n+WQFqPp0biLKN1OZGmTtCMCoE=;
        b=YWq7goex1eQdkmXvSV+dBeUwng3cHswGQtjPOGVNTMjBZ2eFJRUgc943zzT+KeeOtm
         h/JPuIkkg+AAXpfa0fiLlsAPCj3PX1nIgZcKS+NHKEIvEXu4iEd1reTK8f+2P5hVZ2nj
         1uwPFMWsihOx45Ck92drtLK1Hu1Nxd11Uk5DHzqgZtJgvYTP97HXgn9hXTTeEfUMMj1c
         TFxQyUKwng5L15npEnQ8IPuCtWZiSjy9MmIawhs7cgU4V6S/wsY2kXGnJQqL3oyKWFuW
         QkmGDF7VbAtg0WzhBhlcGab7n7TCzELBcM2Eqik8g3pdrK+ce0m0tCsTGKDOQEGMLdD6
         HyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716878936; x=1717483736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2y3qumDVDkg8QQb5n+WQFqPp0biLKN1OZGmTtCMCoE=;
        b=GQyPA0E/rOdGoyOqgfFLXlFFIZ4KOA4J9t2qJMpwi/OU8cnArMZEp1/NHXX62283vN
         Ox4+w3+wVG+4A1LSk6gSgvD5Zz2dr+3ikZLHZ5747Y87yeFY3KL6bz8X9liVKILG9BL+
         T1n9bVssDvlZTCYlJ/JcEY1ZxbNTJiGOfS/1kTTApjR3/WH54Q4rfLANcEDVqMbeHriA
         cbFzR3knVKRPvNMpKqzQHJ4rOFTVkI0NOxboNdfMqHM4dvAhJ0rE7AkNk2bCu18xFvvy
         MSpfiw8FgZ3mp4RPuhn6i7+hU0S0rHPsSAsJ6CFqzqJ4Qz6YuLhci5Sz/tRxnurGQHXa
         +O/w==
X-Forwarded-Encrypted: i=1; AJvYcCUIA3jaUj3y7IsGi5UandPNIXdwnuSthDBgpVTiuRoT1Hop3KW2YsJFhU4gcC6MqTpmhVlQfFXysMH47LQhmhiW74FRiorj
X-Gm-Message-State: AOJu0Yz8uTeot7WNRgGobiLF7jRfnY27yyAW+4fTL5798un+Ut36qTZZ
	sV7+NoN9VcBsA4Yu/5YhQSKT/qTBxVhRO9Hc/ZmIAXLuq++I9o1Kg2SoUHfldFYo2Dbx89sKZ4Q
	xDCaoEXV4dm+90ps6Pr7bBO2ATvxr8Ogr
X-Google-Smtp-Source: AGHT+IEOaGHPfvXlk7twqrFAtpsbfqeVJ1H3FaO6u9vJgeE61K+gqq+HNXxR9gNS7RoiA3OnjdqX6FJEFvvQWSR5jdM=
X-Received: by 2002:a05:6512:29b:b0:523:8e17:444f with SMTP id
 2adb3069b0e04-529650a425emr7370550e87.29.1716878935884; Mon, 27 May 2024
 23:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528021149.6186-1-kerneljasonxing@gmail.com> <CANn89iJQWj75y+QpLGQKZ6jBgSgpi0ZtPf4830O8S0Ld2PpqEg@mail.gmail.com>
In-Reply-To: <CANn89iJQWj75y+QpLGQKZ6jBgSgpi0ZtPf4830O8S0Ld2PpqEg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 May 2024 14:48:18 +0800
Message-ID: <CAL+tcoCSJrZPvNCW28UWb4HoB905EJpDzovst6oQu-f0JKdhxA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yongming Liu <yomiliu@tencent.com>, 
	Wangzi Yong <curuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, May 28, 2024 at 1:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, May 28, 2024 at 4:12=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > CLOSE-WAIT is a relatively special state which "represents waiting for
> > a connection termination request from the local user" (RFC 793). Some
> > issues may happen because of unexpected/too many CLOSE-WAIT sockets,
> > like user application mistakenly handling close() syscall.
> >
> > We want to trace this total number of CLOSE-WAIT sockets fastly and
> > frequently instead of resorting to displaying them altogether by using:
> >
> >   netstat -anlp | grep CLOSE_WAIT
>
> This is horribly expensive.

Yes.

> Why asking af_unix and program names ?
> You want to count some TCP sockets in a given state, right ?
> iproute2 interface (inet_diag) can do the filtering in the kernel,
> saving a lot of cycles.
>
> ss -t state close-wait

Indeed, it is much better than netstat but not that good/fast enough
if we've already generated a lot of sockets. This command is suitable
for debug use, but not for frequent sampling, say, every 10 seconds.

More than this, RFC 1213 defines CurrEstab which should also include
close-wait sockets, but we don't have this one. I have no intention to
change the CurrEstab in Linux because it has been used for a really
long time. So I chose to introduce a new counter in linux mib
definitions.

>
> >
> > or something like this, which does harm to the performance especially i=
n
> > heavy load. That's the reason why I chose to introduce this new MIB cou=
nter
> > like CurrEstab does. It do help us diagnose/find issues in production.
> >
> > Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURREST=
AB
> > should include both ESTABLISHED and CLOSE-WAIT sockets in theory:
> >
> >   "tcpCurrEstab OBJECT-TYPE
> >    ...
> >    The number of TCP connections for which the current state
> >    is either ESTABLISHED or CLOSE- WAIT."
> >
> > Apparently, at least since 2005, we don't count CLOSE-WAIT sockets. I t=
hink
> > there is a need to count it separately to avoid polluting the existing
> > TCP_MIB_CURRESTAB counter.
> >
> > After this patch, we can see the counter by running 'cat /proc/net/nets=
tat'
> > or 'nstat -s | grep CloseWait'
>
> I find this counter quite not interesting.
> After a few days of uptime, let say it is 52904523
> What can you make of this value exactly ?
> How do you make any correlation ?

There are two ways of implementing this counter:
1) like the counters in 'linux mib definitions', we have to 'diff' the
counter then we can know how many close-wait sockets generated in a
certain period.
2) like what CurrEstab does, then we have to introduce a new helper
(for example, NET_DEC_STATS) to decrement the counter if the state of
the close-wait socket changes in tcp_set_state().

After thinking more about your question, the latter is better because
it can easily reflect the current situation, right? What do you think?

Thanks,
Jason

