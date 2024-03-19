Return-Path: <netdev+bounces-80607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006B87FEDC
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 14:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C641A1F232A6
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BE8061C;
	Tue, 19 Mar 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wId3HKGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7E7F7C1
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855109; cv=none; b=LYdGQydrnonA2aqAfe2Jo3BSvJUFYz9goFykJZn90kxBY7gKww021EeSUn5YNKlshmVbZeOzUhlYzyNVLBSbd9xN+iP9P/J5Lw7MWMPSDVztie4uAi3nVgQ/soAVKFDaXgoYFI0Ql+jVH19Y71BVkrcQpqmLCkKN5dUBYZX2Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855109; c=relaxed/simple;
	bh=oTq3CZN4Zju7qN7EjbzOvd+N3X+RLzsgzvo99LiFzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GU9X1aZgbityedNieuZmTtmg9cD0a1ocVP2hq7wneGlPiYR1Lndxa/6e2LF5VtFUleCm+WQLYu/98dEJ46UQJ+6/ie4LzfCcvix70fiY4K5IC7rWlExRGNFvSaaKVVCo1dMYBpNlnGqtieYBowaG1VrO+wi/dvu22GOdfFHTk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wId3HKGk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dee917abd5so152135ad.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710855108; x=1711459908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=wId3HKGk+TuOB9R/FZKVEozItzgiRAWvqLYFoEG4rLg6g/rw0ixG7SuMeWOlF/NHpu
         8un6w5OueU8Lmekt+2otFr4Ik9Utl/DTzUvesjDgHpuXd4BoaDJPewBMM6J3iNFjH9pc
         RMw0yjvf2VROYUcDhDrhD8NQOj2HgAluzh6fxxyTvvtKBoVTLkt50uf8z58N+aEXwCd+
         0cGSayFDHlL78VSmpwIIVM6x+sKv6gu+c1/+JobT5UqcPcv+y7RpE0cNjZ6TQe0fYJPq
         bDSA8Ie8ibQtWRa9wTOkP8zGwjjY8IsXGrlBRJWP1Bw8s/7XRu3KfYXlNKx+Sj8Skk9U
         4XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855108; x=1711459908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRVBERukyS2wWGyjoD0/ZHq0bNlTnq8NUQZ+B3xdj80=;
        b=JNBtePMXQXWOUrDuhde7FrGFHPkoKqhNEOg6ey4+7TS4cCDh3f4WoIAhG+8iAZ7RFI
         jJj4BdzmrsW0MMTB4Wf42MRgnUQ37X/2usiLkrqeMyuorDwhVUVhyuzRz79P/NCFKjUT
         1oZs/jOyrZPdM7jbJyXgaTvM6gS4eSldcgWNlz2zxn5WlXxwZE4EsBabVA72mPpGQ7GW
         rsttE7BSMWFTI1B30rGz2Kv1Lm4O0Ns+jQCwZR1EFqbWlp7q56+y7RsN5Wf9bHl7icJQ
         uAmRsoacHjFD8ryrlaZP7BDzPIPyDGDnYEteHgCgBBKD5ktYA25EGnaltGbKTgkl3v6k
         omZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjftWX0AISU2UM8W9xULQjTeLz/98pyYm3s2/aOXztnFhBiBUA41TukXOnMEjjtSUW3r5aXTLYfm3b74S5t8Rd649sbckC
X-Gm-Message-State: AOJu0YxnLKADwGxji7xPI4Jbd0Nb4XhqD7hyvA2GAQt8j+jdGItu16x9
	Iu7hWQ5yvOtB8Z8xkb4iM9B2AbJUV16EdDbv/2uMRq6JPkBdAfZYlbcOyI6zdtLuDilBY0+14S2
	B5YJj9XvN95wxtmjiRUeW+AaIQolP6DqF8qfb
X-Google-Smtp-Source: AGHT+IFNmXcGYu+lNSQ2iexTWqZe47HUoTeYhNiE93aW579mIfvRqJBheAkUJL1ix5bvm3wn2zyeJjyY46GinXgiC30=
X-Received: by 2002:a17:903:2303:b0:1dd:65bd:69ec with SMTP id
 d3-20020a170903230300b001dd65bd69ecmr240302plh.20.1710855107477; Tue, 19 Mar
 2024 06:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000901b1c0614010091@google.com> <2615678.iZASKD2KPV@ripper>
In-Reply-To: <2615678.iZASKD2KPV@ripper>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 19 Mar 2024 14:31:35 +0100
Message-ID: <CANp29Y7SuK8P8xHa6JzAzs_NxPUN9AvFTiKfMhgLy1POGBodwA@mail.gmail.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
To: Sven Eckelmann <sven@narfation.org>
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, christian@brauner.io, 
	daniel@iogearbox.net, dvyukov@google.com, edumazet@google.com, 
	elver@google.com, glider@google.com, hdanton@sina.com, jakub@cloudflare.com, 
	jannh@google.com, john.fastabend@gmail.com, kasan-dev@googlegroups.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mareklindner@neomailbox.ch, mark.rutland@arm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, shakeelb@google.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On Tue, Mar 19, 2024 at 2:19=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Tuesday, 19 March 2024 11:33:17 CET syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >
< ... >
>
> Sorry, this is a little bit off-topic. But how does sysbot figure out the
> subsystems (like "[batman?]"). Because neither the reproducer nor the
> backtrace nor the console output mention anything batman-adv related.

Syzbot looks at several crash reports to determine the bug subsystems
and in this case one of those crashes was pointing to
net/batman-adv/multicast.c:

https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D15afccb3280000

--=20
Aleksandr

>
> Kind regards,
>         Sven
>
> --

