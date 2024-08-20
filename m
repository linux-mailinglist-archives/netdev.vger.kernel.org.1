Return-Path: <netdev+bounces-120057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C511B958219
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53CD0B239F6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811918C004;
	Tue, 20 Aug 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eelhvZbm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E218B498
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145919; cv=none; b=PnK6wkMdccUXGH1HgfMYVI5+AJXfDLyN8nzDYWRRKnsMRv6tXdaQogu6fswtVJyUZM5TI5FPlQX20KYDrxM5SVZ/MDjZ8iIck6XK8sxDA/UXFtec5I76bKB5sCIGBTiyLYyp1G//kDIvn9Zgvx0op+Ryq6zdKFOyekKaR4zMtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145919; c=relaxed/simple;
	bh=IP5eBMGrlbsjH3D+N9j4JdS9viZRQVvfgWquXq+3hZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is6YA4A5gBQjbBiwJ2vl0swA1Yj76VvbmAgdA7BKO5gS5i0h08PN1EZXKfg7Q1RizYOTqUl0lMk+piIngUhi/DRYbsuITSOB4XPK1Lz4iccp8/g69aAuqhTJCJI7av6tgyxWbyetUuyZpwYvBkNKfzDB3uaAiGGVRSQ6U8a2JF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eelhvZbm; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fb419f77bso260749039f.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145917; x=1724750717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IP5eBMGrlbsjH3D+N9j4JdS9viZRQVvfgWquXq+3hZE=;
        b=eelhvZbmAPDTPTtG8hfCBf8oHRwNE97eEWh0rxer0baxyL1stJ0st4DtiwbFdbTqI/
         0s6eOzR64Ry8nd9bsIQpx2UnhszCAE3f4WYkZARrxhI3eImSIGKTwd6FvMkdNzbYLlcD
         EQvrzNTSnQhU0ewwJIhba5bxp3LEk42a67BGEMlVqulr0xrtWSlUyo37i1LlrnsivdOs
         o4m+p6V7pXCw3tVRmkn32XmJZgDTGSjGbZ32pHyNiSLp2sIVljfcecVNyWVsxdxNJbMZ
         Ay0C5nTUhTNgI+EQgbXcaiHnkGxkdtVHHC/VF4Jx5oTgXWZdduAhO4E818mh0nM1cl40
         h+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145917; x=1724750717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IP5eBMGrlbsjH3D+N9j4JdS9viZRQVvfgWquXq+3hZE=;
        b=WoujKsoSnoB4aNuUJhaKP/zVjnPVuV/AOTDT6YnrG2FL0blKf8WokjKb6mgmBoSjfb
         tJ3ifTpY0WIibRnxPFftkQaHw5MWrkYO8fdMCvSvqkAxJUjh8CBe+NLsxaB966V/xIVb
         n5WlQtSs4IPys1OIUngiKDYoivFQG1X2u6Qnt6IZJNGh/GomsQGlfcU0FLEORNHTrdbo
         G5TpksTvEobleQPcX/ZcvcKxcmCRV24EO54hTuWCNUMPFyJ7PAv2Q2H7PYCWzbSUVAW2
         aRsTAVb8cWeQbOxwxJiQYcRbRFQwd8xgzlQ3gktgbOAZwgllkIWwVuciHWMadxcpZIm8
         cqAg==
X-Forwarded-Encrypted: i=1; AJvYcCW94HdYenrgrZe/am6dOLG/8qLdnVfrUhuh/eIoNf/Xuzf6y6zPR6qpcOifVVryHUNb0p/Me/tILa2Lt9QY4r5bMHYLZljx
X-Gm-Message-State: AOJu0Yy5V014qhgfeVITl2qZSO7iZT/DlGpGfaSozy/U9L6++HgAdnpx
	TsUILOKTpNUOwAjnlOY83CwUeEusXqQv8lDF5idlI52eaiCDwooDDKezhXGD7BZwq4iKR/hXRH8
	J77GzT7ZX2zVw+pSgjLZSkC+3Ca0=
X-Google-Smtp-Source: AGHT+IEHbmb4Pw0NC4KBy1OCgPC7DYMAHTp+SuQVsPHm7MBIXznyB8sSmbRUdlVVgu0wz6GvbDO2LYHdeik4m9xI0cY=
X-Received: by 2002:a05:6e02:1a6b:b0:39b:33b5:5cc1 with SMTP id
 e9e14a558f8ab-39d585c7e62mr16965485ab.24.1724145916963; Tue, 20 Aug 2024
 02:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoAJic7sWergDhVqAvLLu2tto+b7A8FU_pkwLhq=9qCE1w@mail.gmail.com>
 <20240820045319.4134-1-kuniyu@amazon.com> <CAL+tcoBO9Y1+aX6hrt5cG_2V2WOXNvEJ58G8pBw2Nt9+VV3pnA@mail.gmail.com>
In-Reply-To: <CAL+tcoBO9Y1+aX6hrt5cG_2V2WOXNvEJ58G8pBw2Nt9+VV3pnA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 17:24:41 +0800
Message-ID: <CAL+tcoCYhvB2wB7kxD_ZVEgwMgpLyzzLVZcNjSjDw+NLu7dARQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: change source port selection at bind() time
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:22=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Kuniyuki,
>
> [...]
> > > To be more concise, I would like to state 3 points to see if they are=
 valid:
> > > (1) Extending the option for bind() is the last puzzle of using an
> > > older algorithm for some users. Since we have one in connect(), how
> > > about adding it in bind() to provide for the people favouring the
> > > older algorithm.
> >
> > Why do they want to use bind() to pick a random port in the first place=
 ?
> >
>
> I feel sorry to bother you again.
>
> Interesting thing is that I just found some of my personal records
> that show to me: a lot of applications start active connections using
> bind() to find a proper port in Google :) I'm not the only one :p
> Probably coming up with the new algo selecting odd/even ports is the
> reason/compromise for the bind() and non-bind() users. It gave range/2
> for active flow using bind().
>
> That's what I want to share with you :) Hope it will waste you and
> Eric precious time :)

Sorry, it should be "it won't"...

